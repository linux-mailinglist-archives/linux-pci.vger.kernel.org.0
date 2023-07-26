Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA233763BD3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjGZP6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjGZP6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 11:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EFEC;
        Wed, 26 Jul 2023 08:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010B761B9A;
        Wed, 26 Jul 2023 15:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C9CC433C7;
        Wed, 26 Jul 2023 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387087;
        bh=5/2WIkH3ivN82XrLHbAGYxs3qOosdEacLmdz4wwgnyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bMpKP92rCogimOe0Se8nuOkLeik4RglTOco6wRwebCqkqFHRQ+N6hn9QpVY7nda/W
         XZ1Am0xQy18LCSpruZzgH4bj7pqjZU8kjDLCyrd+oV7PZdpY85+xODMy3zm0aUSyJs
         jXIyfDnlVvC8/P6G/frmNNMqWKPa0e6z/Vs30xeHAz1MNnQH+O6HWabFH480xpqDVa
         WkU4RhU4doPKvcDtyJ/X7NwhPWyLvXI+FWE/H79JE9/ELtkksK5cXDNelKUlfLmRVB
         JXYAw6yYF25Dj6CZFpUZjFK0jps6M7WvRRJZMQoN/vJ+NJBluh9ueIW3sPjQpwKoRn
         aV7HeJ4a+aRuA==
Date:   Wed, 26 Jul 2023 10:58:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <20230726155805.GA685773@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMDZoJgBtURn-Vf5@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 10:30:24AM +0200, Johan Hovold wrote:
> On Tue, Jul 25, 2023 at 03:05:15PM -0500, Bjorn Helgaas wrote:
> ...

> I think that adding the corresponding Reported-by tags and Links after
> my SoB below should be enough to credit reports that I was not aware of
> when investigating this.
> 
> But if you decide to rewrite this paragraph, then please spell out "for
> example" as I would not use "e.g." outside of parentheses.
> ...

> Looks like you've "sorted" the trailers here instead of keeping the
> temporal order (which would make it more clear what you added after I
> posted the patch) and adding each Link after its corresponding
> Reported-by tag (e.g. as suggested by checkpatch these days).

Updated as you suggested, thanks.

Bjorn
