Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03DB6E2AB7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 21:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNTmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 15:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB403F4;
        Fri, 14 Apr 2023 12:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44BA564641;
        Fri, 14 Apr 2023 19:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57066C433D2;
        Fri, 14 Apr 2023 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681501361;
        bh=YGz9MbLmcxJzOrhlvaYJJIwgwtrTg2ca7eXHAJzTnHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h6ZWHUl6KYrf47qMAefx3/ea+3AlHAe+Y93z7WQiGw18HughJc7lVhVVfJSwmauU4
         6EA9Ae0ROmQVN3+cNHohhxpXz3IEiuI5dPGda6CSGnX//MEMesm68iY648GgBZO1Th
         zQafuuakjM6arQsle2m5YRFtJDVryshy+UZ4/7rx/I9M+e1k3txthlqnrkjdeF0tnj
         vgWtgFIa7vfuvQovZHVWiKHdULvVJVT9MGVrRcJQnDGeOLbVmJCPr5DadnjLyYM1nW
         YWoGsS3/LtZe+rrOlNOc+wJWd6W9pUVr/pkvfyO3/V+tGIqSdioHEtXF9woO6i2xO7
         H30NC4+hfAUMw==
Date:   Fri, 14 Apr 2023 14:42:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v12 11/19] PCI: dwc: Add support for triggering legacy
 IRQs
Message-ID: <20230414194239.GA214436@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414061622.2930995-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 03:16:14PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering legacy IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the terminated at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.

s/terminated at Receiver/Terminate at Receiver/, since I assume this
refers to the Message Routing mechanisms in Table 2-20 in sec 2.2.8.

I have a slight preference for using "INTx" instead of "legacy IRQ" in
subject, commit log, function names, etc because it's more specific.
"Legacy" is clear now, but tends to become obscure over time as more
and more features are added.  Eventually it just means "something old
that we don't like anymore."

> +static int __dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no,
> +					 int intx)
> +{
> +	int ret;
> +
> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA + intx,
> +				  PCI_MSG_ROUTING_LOCAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);

Where do these values (1000, 2000) come from?  Spec reference would be
good if there is one.

Bjorn
