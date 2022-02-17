Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018C4BAC18
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiBQVyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 16:54:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiBQVyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 16:54:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807CE15C9F0
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 13:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ACD4B824BE
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 21:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7243BC340E8;
        Thu, 17 Feb 2022 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645134840;
        bh=xP5xeZAqDD1u0mEd6acpgyl8Fe27+OwMzfyWe93kwDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WnIn5wcv7uxkkZZU/YFDerLBOHTK85rVDpzf88MMDKVXFYk6Sb5ohvfealmhs4OM0
         akmim/Xh17Z30Ag66208UP00zplVNo1WNFFQkOWlf8GccAQlABj7KoFC4NEjfVRdNL
         LP6vkrS4KZJ6f10wxeCRtwMR1/yVaf4C6Ct2ohb9+BzZcMGrITnA430lE9cIIOlbAs
         1CNCSzJxOMeTTJNSf8IOV+RkvYhfh0HoPKiLREvaqQ22NlUFmAZZWC5+4vwif5ILTR
         snf1+YvXc0jzDOh0orp0v+huf/K+v3tHu58ZaH2Qms/eMdtN4MndlR3E8lh+vuRZS2
         iJaRIZuNdfzsw==
Date:   Thu, 17 Feb 2022 15:53:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: Re: [RFC PATCH 1/4] PCI: designware-ep: Allow pcie_ep_set_bar change
 inbound map address
Message-ID: <20220217215358.GA308489@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215053844.7119-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the subject, "pcie_ep_set_bar" looks like *part* of a function
name.  Please include the entire function name and add "()" after it.

On Mon, Feb 14, 2022 at 11:38:41PM -0600, Frank Li wrote:
> ntb_transfer will set memory map windows after probe.
> So the inbound map address need be updated dynamtically.

I don't see "ntb_transfer" in the tree.  If it's a function, please
add "()" after the name.  Otherwise, please say more about what
"ntb_transfer" is.

s/dynamtically/dynamically/

Please make the commit log say what the patch *does*, not just what
needs to happen.

Bjorn
