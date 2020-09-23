Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2179276147
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWTpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 15:45:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD648C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 12:45:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so667785ljj.4
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
        b=O9FTvRdvjPNRL462v9lU8NIGlyHwkPJ5W9/eQ0TRTTQQwnaFxTZYWBlUU1rxo4C9wR
         XKCjF/OEpnVpB1Hx8iwZ4/Q24/gWv1FUF75tZuce80eU9w3H1KRzmhltU5WLEXbR8qMZ
         lr50EYWyEA2wU+zKRJVODvRN+LLAaCVTB9TIAc2zhdNcGkCjKxyf95y9S0zTpWzFIfQc
         zltn6UqVGdCk6jTwRBa3tdFUUeZIN3nErofso7zTU8hFeytLzETmtF0DNgN132Nvl+QN
         d5i/zB8Tex55NdNjabAdvug3kj99BjJsv1HnljfJjOpiNzk+QXco5JVHODj4vGXcG09G
         sFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4e3pg0c/Zru5ZWtPKdeWn+c+nXGAjJi5U8aCz3uzeQ=;
        b=ZH3zCXG/yTMfQu0mmFJnK5RcpWnKPExTjU32CqWHos7XL06/4BqhBbt33PF9NURmgS
         Lj0lcEEEi1TTODeLd+rxg8wCGDZoPoGO0O41heK8aOxWmysFujz+xfUb8YcOUDZpHWxA
         7F9q9+o7FhUQCQY15HCp9O0DbelBY8DGUslolSmoLSYWmjWCZcFahEjwW8NZLnNUlFTu
         cQZg2iygi71PJvYWYC7E/fwLZMAoLSrCSZT3rxgE8hRY4ZiIc4hl+7TAxhwt6WQFqGqx
         ge28c63O+d7uNpAU1cAvV7223W54F1ClypkATSnHPxautwZKorjUBtlZUF4p+djMpJTA
         UXjg==
X-Gm-Message-State: AOAM531j05jct35WpCAN6J7BArr60mnaAn8V3EKdVz2jqqiMhNanOM0d
        rjfCtJqFbG6kW5Ie10EsCT+h+q/VWjtyzNrWPP/Kbw==
X-Google-Smtp-Source: ABdhPJy4oRt0D9rAphLkS6oUMlrRISLyr5oeHKiOWqU9MeWzlP89ss68bpX12wL2+9Wg6MMYiYJlPXW7BeKR0U5TOmE=
X-Received: by 2002:a2e:3208:: with SMTP id y8mr480904ljy.216.1600890348085;
 Wed, 23 Sep 2020 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923160327.GA2267374@bjorn-Precision-5520> <20200923161944.GA17764@otc-nc-03>
In-Reply-To: <20200923161944.GA17764@otc-nc-03>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 23 Sep 2020 12:45:11 -0700
Message-ID: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Bjorn
>
>
> On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > [+cc IOMMU and NVMe folks]
> >
> > Sorry, I forgot to forward this to linux-pci when it was first
> > reported.
> >
> > Apparently this happens with v5.9-rc3, and may be related to
> > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > which appeared in v5.8-rc3.
> >
> > There are several dmesg logs and proposed patches in the bugzilla, but
> > no analysis yet of what the problem is.  From the first dmesg
> > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
>
> We have been investigating this internally as well. It appears maybe the
> specupdate for Cometlake is missing the errata documention. The offsets
> were wrong in some of them, and if its the same issue its likely cause.

Can you please also confirm if errata applies to Tigerlake ?

Thanks,

Rajat

>
> Will nudge the hw folks to hunt that down :-(.
>
> Cheers,
> Ashok
