Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6762244F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 08:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKIHBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 02:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKIHBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 02:01:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2517A8E;
        Tue,  8 Nov 2022 23:01:06 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so15426027pgr.12;
        Tue, 08 Nov 2022 23:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbeXqCLYOBAkSu17j1Ax0Kt+U7TED+WWpiIs96MmSJQ=;
        b=ETQb1tI1n+hbxllKBl6w8Mzyr7cXZO/XD+x0ciAoyUVLYi8hvbbWAMwRBbk+lPUh/w
         PCA94vr5XLHgQYfaTLUfkBwneUE/weZaQB5w1p2mFJQJeeiWlKZhDoOyakxO1YTFTnTt
         v11r3VFzj1zLLAk+kP4tS+nTjpVxvy+StKqvKTdbKzGWYo0CnM5r2igLKQj3X6CvzphC
         Ns0AAzcbmL/GK7jzrouVpuQnCA+63fQPF8S061YvoOn80+H2fb2BXzeWO0MA0lpMGQuz
         b+NFxF/BgQ12eDG/5fITtPjlhVDeyN0K3POf8hCLZR5Yufx1U6nzBQp4zckMbDukYrlQ
         fMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbeXqCLYOBAkSu17j1Ax0Kt+U7TED+WWpiIs96MmSJQ=;
        b=U/nsEXkBsqZh5F/s2GPFellFRtQvYF9fPjFvmpb7cdSE9VJtHVZt0TV4a55a1OUHWk
         Lqur5ThFPbptqZr6bsNndhkQJmqhbNioOmamYhRcb4HwFNVluouHjkvwo4esBRzT5csY
         4xHLO9GSHVekOFYc+zS3aXE5GJTV3eqqM8pqku3jlno1YCddewfsEt5/KjEfSZ61m1Mb
         dTixtI0Q8nNw9ltOuqgbLDUBaxNV8Me+gdNlprrAssiblutdS0zWZa04LNas2nHlm1mn
         EU+Y5n1aAcOavGuf7pPJpVaCZl8KTo0EeSA+TzZE08Re2vZtKLqJNrbHM+HmQh7Yvkgb
         yPTQ==
X-Gm-Message-State: ACrzQf0luMkWmU347xHUqkrGSwpegA9xDQW0OukKtsaGpIqhKPr0EZsH
        wlhw/iIdczcwshRWdXAxlZY=
X-Google-Smtp-Source: AMsMyM795gszhK4X1M96+Do8Mj4ERULjT+qjBrDIXvIiGLRDDaHXLJtpBwdSnxCUjX6nA+ExwUhWig==
X-Received: by 2002:a05:6a00:234c:b0:56c:f6e6:976 with SMTP id j12-20020a056a00234c00b0056cf6e60976mr59755657pfj.32.1667977265677;
        Tue, 08 Nov 2022 23:01:05 -0800 (PST)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79499000000b0056ca3569a66sm7476726pfk.129.2022.11.08.23.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 23:01:05 -0800 (PST)
Date:   Wed, 9 Nov 2022 07:00:45 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109064807.GA903798@zander>
References: <20221109043617.GA900761@zander>
 <20221109051234.GA532217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109051234.GA532217@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 11:12:34PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 04:36:17AM +0000, Wei Gong wrote:
> > O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > virtio uses the same driver for VFs and PFs.
> > > > > > > > Accordingly, pci_device_is_present is used to detect
> > > > > > > > device presence. This function isn't currently working
> > > > > > > > properly for VFs since it attempts reading device and
> > > > > > > > vendor ID.
> > > > > > > 
> > > > > > > > As VFs are present if and only if PF is present,
> > > > > > > > just return the value for that device.
> > > > > > > 
> > > > > > > VFs are only present when the PF is present *and* the PF
> > > > > > > has VF Enable set.  Do you care about the possibility that
> > > > > > > VF Enable has been cleared?
> > > > 
> > > > I think you missed this question.
> > > 
> > > I was hoping Wei will answer that, I don't have the hardware.
> > 
> > In my case I don't care that VF Enable has been cleared.
> 
> OK, let me rephrase that :)
> 
> I think pci_device_is_present(VF) should return "false" if the PF is
> present but VFs are disabled.

I agree.

> 
> If you think it should return "true" when the PF is present and VFs
> are disabled, we should explain why.

I don't think it should return "true" when the PF is present and VFS
are disabled.

I think pci_device_is_present(VF) should return "true" if the PF is
present and VFs are enabled.
In the current implementation, it cannot correctly judge whether the
VF is present.
When the PF is present and VFs are enabled, I think it should return
"true", but in fact it returns "false"

Through your comments, I realize that this patch is inaccurate in
judging whether VF present in the case of "the PF is present and 
VFs are disabled"

Thinks,
Wei

> 
> We would also need to fix the commit log, because "VFs are present if
> and only if PF is present" is not actually true.  "VFs are present
> only if PF is present" is true, but "VFs are present if PF is present"
> is not.
> 
> Bjorn
