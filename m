Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141C539213F
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhEZUHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhEZUHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 16:07:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39255C061574;
        Wed, 26 May 2021 13:06:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so974555pjt.1;
        Wed, 26 May 2021 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HaQh1xHx0RKGFHhlfN+UdbNk8CmfpFB9XcWgnBNU2wY=;
        b=j+k3BZxmWGcIJp3uMrDVeZpXlhd/668NmKohHu1S+pqRfF9FdvMynGxm076WastzKy
         yy8MsJ3t4k/XZXY6x+dSwfa+6xPu1mOpeBfzGWNyklnChG8fWpaX0be6CD7LS/jyZ6Su
         Q1NhShyUnjxb92Ae0oyLmkh0vtdaY6OpkFuqrwzjbK7sOsPF62AK04YMMrbnyEx6F/r/
         c2K3jdmRG2MZmqfoCpOXd910lPT5fGOuNu2Psef0if9UnXexCvo0+Wa5wljAi2wf1t5r
         xcgQLgzFQpmGqQ+xmTZq0Xy+J2Pri732eqM1sKE2EFPT4Ivoc6GNM8KmHEbxz0Vvj7mb
         22zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HaQh1xHx0RKGFHhlfN+UdbNk8CmfpFB9XcWgnBNU2wY=;
        b=oCwTMv3ZC7FLuzoZ8gNLPQGV/bTDVmh3UO7qhWuwhhv0glyOR8/8OGxg2zg1j69Kwl
         FhIPyHP5eAopR5BQrJ+ta/M+1yQ5fQFI+X1DVSg+5LUi+mc14NPlTeixkV1K7RZtbYvn
         ft/rCKbHYMgmYNyu+o+uK745Poqs+ombSO1E2A1x+OKrEUqqlM0/5vHImgTWeaSUZIMN
         yQK+kPo1lL5hibM1UInnjU3p0wnVNAaeEPKRpFE8JxO+ohF2kkA7aOFM1f4PkaM5Guuz
         1UO8hUWvHfCJReha9QWb0LlOoW4FtDpLF3PioPx8BKSsPTjEyMOu0dB5MLM8IIMgS28s
         uxqw==
X-Gm-Message-State: AOAM531fDVUxxP4kWjKBSif7RM5vBfa3W+MPhJltBmGng7zvf9yHvWzZ
        KWqw1XdkGlOfx3qUASTFf+M=
X-Google-Smtp-Source: ABdhPJxFa+ezs2PwsZaqDch9NcqAST8MFI1eicLBlGIuP6oAP5C6/DWWB6sWCCcu2hK7upYMUMhKEA==
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr5562485pjp.155.1622059559820;
        Wed, 26 May 2021 13:05:59 -0700 (PDT)
Received: from localhost ([103.248.31.164])
        by smtp.gmail.com with ESMTPSA id c1sm52629pfo.181.2021.05.26.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 13:05:59 -0700 (PDT)
Date:   Thu, 27 May 2021 01:35:57 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 7/7] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210526200557.5wrrmflygfmdzd6b@archlinux>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
 <20210526101403.108721-8-ameynarkhede03@gmail.com>
 <20210526135230.2ecd94d3.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210526135230.2ecd94d3.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/05/26 01:52PM, Alex Williamson wrote:
> On Wed, 26 May 2021 15:44:03 +0530
> Amey Narkhede <ameynarkhede03@gmail.com> wrote:
>
> > Introduce a new enum pci_reset_mode_t to make the context
> > of probe argument in reset functions clear and the code
> > easier to read.
> > Change the type of probe argument in functions which implement
> > reset methods from int to pci_reset_mode_t to make the intent clear.
> > Add a new line in return statement of pci_reset_bus_function.
> >
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
[...]
> >   */
> > -int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
> > +int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, enum pci_reset_mode probe)
>
> This should use your typedef, pci_reset_mode_t.  Is "probe" still the
> best name for this arg?  The enum name suggests a "mode", the MAX entry
> suggests an "action", "probe" is but one mode/action.
>
My bad I missed this. Which sounds more intuitive to you
"mode" or "action"? I update this in v4 to use consistent terminology
once we everybody agrees on name.
[...]
> > @@ -3910,11 +3922,16 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
> >   * device too soon after FLR.  A 250ms delay after FLR has heuristically
> >   * proven to produce reliably working results for device assignment cases.
> >   */
> > -static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> > +static int delay_250ms_after_flr(struct pci_dev *dev, pci_reset_mode_t probe)
> >  {
> > -	int ret = pcie_reset_flr(dev, probe);
> > +	int ret;
> > +
> > +	if (probe >= PCI_RESET_ACTION_MAX)
> > +		return -EINVAL;
>
> pcie_reset_flr() handles this case, we could simply test (ret || probe
> == PCI_RESET_PROBE) below.  In fact, that's probably what the code flow
> should have been regardless of this series.
>
[...]
> > -int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> > +int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe)
> >  {
> >  	const struct pci_dev_reset_methods *i;
> >
> > +	if (probe >= PCI_RESET_ACTION_MAX)
> > +		return -EINVAL;
>
> If we test this here, none of the device specific resets modified above
> need a duplicate check.  Thanks,
>
> Alex
>
I went ahead with excessive error checking in this patch.
Will update in v4.

Thanks,
Amey
