Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFB4ECD09
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiC3TMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 15:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350567AbiC3TMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BA33EB5;
        Wed, 30 Mar 2022 12:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8DD61382;
        Wed, 30 Mar 2022 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A1AC340EC;
        Wed, 30 Mar 2022 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648667420;
        bh=Bd5+M5VE8rRc0rP6ib+x8ifz4fFdKR2N/GFKCemE0wg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C3KMnOikqv1wcAcW5I1otZz0XYVl5QKrPmo8+DHJvrqgMgQ/iaxOiDIbQQx28K/m/
         qK6yU594heIvLs2Q5i6yxe7kFwKScfDvs3H+jCQprM6tO/OSuIKtNW1cnjxZ0+sPmE
         0VGNvAWxSGQr5aAoWLP4hZH+TLebHIXEu6B6nOmXE3Hg7mzXfR+Hq0jI+brUzIb8OH
         1WTwhxKswpv5mMEKr/BILx9k4x17MK8NOs++6eT3ldzDXYTy1s5w6lyhjGHOX8rpvD
         3qZ07JMWKAu/sjux2lp/nNFphtTkn1Lf52LnyyJUIpkLcQJsKNz/Ngr6XtJA8YwTVR
         9f/uAEuvaE1KQ==
Date:   Wed, 30 Mar 2022 14:10:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220330191017.GA1700536@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330153720.GF1716663@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 12:37:20PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 30, 2022 at 05:08:23PM +0300, Shlomo Pongratz wrote:
> > @@ -350,7 +353,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
> >  
> >  	if (!root)
> >  		return NULL;
> > -	if (root->devfn != PCI_DEVFN(0, 0))
> > +
> > +	/* Is it a host bridge or a root port? */
> 
> This is a better comment:
> 
> /* host bridges must have a 0 devfn, but some of the entries in the
>   whilelist are root ports that can have any devfn */

Is this something in the spec or is it just common practice?  The PCIe
spec says very little about "host bridges" and I don't remember
anything about them having to be devfn 0 or even that they have to be
materialized as PCI devices.

> > +	if (root->devfn != PCI_DEVFN(0, 0) &&
> > +		pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT)
> >  		return NULL;
> 
> Indentation is wrong
> 
> Jason
