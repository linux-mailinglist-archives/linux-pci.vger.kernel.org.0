Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142214BBA01
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiBRNVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 08:21:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiBRNVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 08:21:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBC2B31A0;
        Fri, 18 Feb 2022 05:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6884B61755;
        Fri, 18 Feb 2022 13:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1A3C340EF;
        Fri, 18 Feb 2022 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645190441;
        bh=Bq8uHmrbwFFflKpEPD9pGPNauay9ErYLdZGVjuU6bf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G7Tls6vhg9AjFl1lMZO15h5+1DzK81r+7PHA3rwqnbVxkeQl08Fb6gFSWLUbLKI0s
         x4lkX5K8mjCTjNHKVAXsIJYBL2rg+BXdBIWEbOApgOiDJCeVPjpCLb/Xp/7Yo180rB
         6iX60M6USeZPwKM5Q3paIMi85QNbx1i/43Fg+5LK+A6L71PEM8/epmiKxWlFX9a7LI
         mjPVwqwUIeAdejkVSo8IQhUfiqQF7iGCXFrzS9JOO44f3SxNFnNKIyoSbf6dLSKYou
         e3zLyYJPt8kUwMpXbCR4c57sJUoE5dSuN1HCj+9e1OyUr+KatQe/+2SPOjwqQjDQ+E
         UE6Ocotsmlk7A==
Date:   Fri, 18 Feb 2022 07:20:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <20220218132037.GA345784@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac4cc7e-f81e-82e6-9b60-e5e3199637d7@ti.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > Update subject line to match previous conventions ("git log --oneline
> > drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> > 
> > On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> >> This enables the Controller [RP] to automatically respond
> >> with Response/ResponseD messages.
> > 

> >> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> >> +{
> >> +	u32 val;
> >> +
> >> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> >> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> > 
> > I assume this is some device-specific enable bit that is effectively
> > ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > Capability?
> 
> That's correct. This bit enables Controller [RP] to respond to the
> received PTM Requests.

Great!  Christian, can you update the commit log to reflect that
both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
respond to received PTM Requests?

When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
and the PTM Responder Capable bit (for which we don't have a #define)
read as zero?

I think that would be the correct behavior per PCIe r6.0, sec
7.9.15.2, and it would avoid the confusion of having the PTM
Capability register advertise functionality that cannot be enabled via
the PTM Control register.

> >> +/* PTM Control Register */
> >> +#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)

Other #defines in this file use lower-case hex.

Bjorn
