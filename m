Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFA4B9561
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 02:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiBQBUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 20:20:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiBQBUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 20:20:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130502A0D46
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 17:20:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j4so3371982plj.8
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 17:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7cadtmmQLWpqnDfNO/7BqDxIT7kznXIolyywHVAbf4=;
        b=sS4wdzZnPrT37CjCYgWCu8TLp11Ei7CFxuIjGDv44Mt2ivHoti/wY6MSdwNP0cKoXs
         Z21zfBugMb1CY2vsjABdEjflXhE4sdqTYSfDLkoAWfYWucbo1M7uHtiAqtTpogLYrl0T
         Bny4tAEmHxEn1N7T6sp5A5zMZsLgdkoxEdNhQMBVzalmJx54O6aDMEOdT2Io7FbEn8kA
         36+YLJcNQWtJzG2nJiiiuLwlw2U0p7FhhKvp6vg923Gz/g7rsu250azpMQiZTwABpqnr
         uPRpauBD6c9T+s5+i/bFlkwQZ/rM3RoYv8gkX6G0ez0kJPNKL/hqyrwrK3Wz+5D7lGGk
         Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7cadtmmQLWpqnDfNO/7BqDxIT7kznXIolyywHVAbf4=;
        b=CmdVyJ8dYN0AY9dSOtoPGooqJdDE6Cm2Ohq5124MOmhcR0TEJtXGC/kOeurCJHKziQ
         3V8CXG+XXY+MacDhPLXTuqA4V0DixmV26pJGTgimJGOfUZKn4WaOe5jNZ/9ePAFs0Wu9
         RY582ECVtlUsgzNgQ6+h6CcV35vSwJJ5Cz4PmpGmzzk/h95VNNiE4WsB6PDv80cfZfNg
         l/ZZBie/BbE4B8Qb0GtlgKDE1w15DLtlm3+ISAYVvxJSFiA33we2gYEcAz9rzGAcwhKV
         VHfFZbm/AofIslQU6UYCl2B9QX0wrXEDJVsvpgGyEY/x1K0E1V0daGnndz057VDLTgsw
         +PSA==
X-Gm-Message-State: AOAM531tL6DPL2QGrqQnWjYyPCq9WMmKTSHW0AMqDIV8+Cdqbx7DIVTU
        akqWQUHmnKq7OY2JA/RJpWPitouzsqiXgh0oBQhZdg==
X-Google-Smtp-Source: ABdhPJwGogsHvhC8P7qOIe64MKrYPXZoUlX6w2MClweVcGHPqJw7K83Y/KeKSJi0yGjqpvs9L6OgDsIEYrhg9zspKmA=
X-Received: by 2002:a17:90a:f28d:b0:1b9:975f:1a9f with SMTP id
 fs13-20020a17090af28d00b001b9975f1a9fmr598286pjb.220.1645060839612; Wed, 16
 Feb 2022 17:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-4-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Feb 2022 17:20:27 -0800
Message-ID: <CAPcyv4idjxVE=U8wQJj+7cZ+ZxP79q6GqCdQG4GQZ8pRX3fb+A@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] cxl/mem: Cache port created by the mem dev
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Since region programming sees all components in the topology as a port,
> it's required that endpoints are treated equally. The easiest way to go
> from endpoint to port is to simply cache it at creation time.

As of 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver"),
cxl_endpoint_autoremove() already sets cxlmd drvdata to @endpoint, so
this patch isn't needed.
