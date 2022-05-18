Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E7352BE3D
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiERPJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiERPI7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 11:08:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A4178542
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 08:08:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so2550171pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAOqA96aToO86xRKYS8qEzOGQS2kjgufaDi6zqwGWHU=;
        b=O5xf+78qJhBHBcQ1CwJqcQ438s2ghvqvjXK4zlGjV2hTmpoNr2FDX8aKjDlMliuwhk
         bPZyUfKFKL2YZsA0K/m3RnX/X0rhVMzKNcpKaxRTHVp6haXLuqIlfgcc9lbl2EaSRLlA
         nTxDb9MkN9LlDfKRMEnzrZsnM6N4LlJfic+rsomjjxTkYMyZ20GXCerQlWJmhKWtVq6j
         RaG8gIhHxPSYXNMMGk7naphxKx5duxHZFEjtd5vtJCpTB1vc16g8ROEqNA4IzGKwPtdw
         20ifpFt3ESIseO9gyTSmcahllZJS/VOUcRiEnpVWiepnOgS6ku1L5OFeyesWIBZDapDB
         QUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAOqA96aToO86xRKYS8qEzOGQS2kjgufaDi6zqwGWHU=;
        b=FUjenyLjlUxCjvoPRLPEcYAnY+AjJ7CvficoS5S/rGH7YEJNOf3Qy21NMTguq5w3R3
         txnBaJBmFCxrI4sbHZoCTIxdwWB5Wykyf6QRtpV/9HYxUNFrqzObDLyQlcGF7uP4Sjd4
         NyhKer0gbLX+Zb86yVn93CnZtU6LBjQcpGSXgOMcpZs1fWXBnbMC8zcSQA45IYpvbJt1
         48BSB9F820zPApRj5LSnebb/4fSyvA3GZLIaFHH3BOJ5aor9zZMTKhYzN5ukoPTdAsQu
         eLg0eAVSx1P3BmpEVuKP1Y/bppcTpk271qZZmiNbGc7iyGcrFqOD8RH9FuSy8jvW3x3M
         TUpQ==
X-Gm-Message-State: AOAM532nQhdtS6fRgY2EXsG5c3WUcOt/B1YNYpQPVH6ACj9kVxlQLjqW
        XqH8hOTom2vaiC2DVLx2Ze51iN0xX4+k+Aicvlrshg==
X-Google-Smtp-Source: ABdhPJwhxMNnK7nG2eB3nT+2rJn4Rnr7ZBkWavdd1dpNrBulUMGOcRCebYPLvRZ8zt6Ji5T+F8TOMcqIk8Sfr+z4YDE=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr189626plx.34.1652886538210; Wed, 18 May
 2022 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de> <YoT4C77Yem37NUUR@infradead.org>
In-Reply-To: <YoT4C77Yem37NUUR@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 08:08:47 -0700
Message-ID: <CAPcyv4jb7D5AKZsxGE5X0jon5suob5feggotdCZWrO_XNaer3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 6:44 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, May 14, 2022 at 03:55:21PM +0200, Lukas Wunner wrote:
> > Circling back to the SPDM/IDE topic, while NVMe is now capable of
> > reliably recovering from errors, it does expect the kernel to handle
> > recovery within a few seconds.  I'm not sure we can continue to
> > guarantee that if the kernel depends on user space to perform
> > re-authentication with SPDM after reset.  That's another headache
> > that we could avoid with in-kernel SPDM authentication.
>
> I wonder if we need kernel bundled and tightly controlled userspace
> code for these kinds of things (also for NVMe/NFS TLS).  That is,
> bundle a userspace ELF file or files with a module which is unpacked
> to or accessible by a ramfs-style file systems.  Then allow executing
> it without any interaction with the normal userspace, and non-pagable
> memory.  That way we can reuse existing userspace code, have really
> nice address space isolation but avoid all the deadlock potential
> of normal userspace code.  And I don't think it would be too hard to
> implement either.

Yes, I also want something like this for mitigating the vulnerability
surface of things like PRM [1], where platform vendors are looking to
move more runtime helpers out of SMM mode and into ring0. I would
rather see those routines move all the way into ring3.

[1]: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf
