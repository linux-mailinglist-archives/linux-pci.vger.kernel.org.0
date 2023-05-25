Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF73710926
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbjEYJqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEYJqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 05:46:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDBAA9
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oTK7jsFG28WXK3rbDJ/X/Ehdt81MjRxqzlzU9gtnCdI=; b=GCvl5EpAe4K7xorgvYX2XrZY+l
        ZHjzsPZmS6uPnJEDZgkpv1YolqRKeRvnJVfXQcEH/6MhsiI4lCj9rZL7bi0Cz2HVqXuCBF2458npC
        qct8mWiVBOlbDH1Upozmbw6HDpfGsSZTqhUt9cWZ5+rMQK2yUW/5nz157uwKoRxQpwq4FmJeq+17M
        whMfn2hfs0V4htWG+NlwFI6YrErSvFfGz/8q4vsfncbt3DND4jrpm7Fw69l2TkB1Oh1bBDMDlx3s2
        zHzLfi59XfctH7e3OoaElA3O6Ad6bqCLDbjhb+aZ+cnapfLh/6/ag0Yz2VViKoV+NPWmiakEx34Pn
        Cnm7wEqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27YF-00GBSU-10;
        Thu, 25 May 2023 09:46:31 +0000
Date:   Thu, 25 May 2023 02:46:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Shiwu Zhang <shiwu.zhang@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <ZG8ud4JWpF7BXJ7c@infradead.org>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 10:02:32AM -0400, Alex Deucher wrote:
> On Tue, May 23, 2023 at 5:25 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> > > +     { PCI_DEVICE(0x1002, PCI_ANY_ID),
> > > +       .class = PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> > > +       .class_mask = 0xffffff,
> > > +       .driver_data = CHIP_IP_DISCOVERY },
> >
> > Probing for every single device of a given class for a single vendor
> > to a driver is just fundamentaly wrong.  Please list the actual IDs
> > that the driver can handle.
> 
> How so?  The driver handles all devices of that class.  We already do
> that for PCI_CLASS_DISPLAY_VGA and PCI_CLASS_DISPLAY_OTHER.  Other
> drivers do similar things.

How is that going to work in the long run?  The chances of totally
incompatbile devices from the same vendor appearing is absolutely given.

> The hda audio driver does the same thing
> for PCI_CLASS_MULTIMEDIA_HD_AUDIO for example.
>

That, just like PCI_CLASS_STORAGE_EXPRESS is a different case, as
the class is associated with an actual documented programming interface.
