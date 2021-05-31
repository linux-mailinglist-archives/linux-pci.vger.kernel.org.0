Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE63961AD
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEaOpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 10:45:17 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39571 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhEaOmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 10:42:24 -0400
Received: by mail-wr1-f51.google.com with SMTP id l2so3706991wrw.6
        for <linux-pci@vger.kernel.org>; Mon, 31 May 2021 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhAKSxwqbTqNpIA9TBDclmDBGCmKwmqWFDzjmFaPa6s=;
        b=a5tKP/irQ/dIs9GqtfUaDk1ayITxV+UuLuNy7ZK4qjQ1vip4ZWswKQeDITCNNBhnsW
         7p/WnGyXV108S86irZUugVo0wGux+JHBiSG56nh53aKUgT9y5f7KKJELyE1nPoMlfP7I
         j5o73+uF8N8mCO3nimfsd5zPyTBRtrhIiHjfi8aC10UEp7PgtyylLwKg3im6SSQbV4cl
         snx23DRADTk1buvUs6HEbBRQiYlZba4ari/HsNl7efbAne5Xu20ZHqrmcnq9oCa1Vvqe
         GZhezU2PK1zeaR+VKF2aP7o51ovln6KMFLaV6P14nXh1Kfd2LmN7T/ErN329+T7U9C91
         N7gA==
X-Gm-Message-State: AOAM531R4c8222CafT8lzr/SAf2sWfAWEWFQ0yQOY5jvGuhwrCnf1oP7
        nQEUw8RAPwlTl76MgwsNUPc=
X-Google-Smtp-Source: ABdhPJxZEbDYwhiQ6e+F+jKDvTB8H9i0VIH3Gi8v9zTI9RGfzWtgNoHtK7WWxg40k7vkKudVyxkHeQ==
X-Received: by 2002:adf:df87:: with SMTP id z7mr7278724wrl.56.1622472042672;
        Mon, 31 May 2021 07:40:42 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z5sm17175128wrn.69.2021.05.31.07.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:40:42 -0700 (PDT)
Date:   Mon, 31 May 2021 16:40:41 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     linux-pci@vger.kernel.org, Alexander.Deucher@amd.com
Subject: Re: [PATCH] PCI: Mark AMD Navi14 GPU 0x7341 rev 0x00 ATS as broken
Message-ID: <20210531144041.GB157228@rocinante.localdomain>
References: <20210531081031.919611-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210531081031.919611-1-evan.quan@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Evan,

Thank you for sending the patch over!

A small nitpick: the subject line could just say:

  Add quirk for AMD Navi 14 to disable ATS support

Or something along these lines, as I am not sure how useful the ID and
revision are in the subject, especially since the commit message
explains in details what hardware is affected, etc.

> Unexpected GPU hang was observed during runpm stress test
> on 0x7341 rev 0x00. Further debugging shows broken ATS is
> related. Thus as a followup of commit 5e89cd303e3a ("PCI:
> Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable
> the ATS for the specific SKU also.

As this might be a candidate for a back-port to current stable and
long-term kernels, does it have any "Fixes" tag we could include here
for reference?  If not, then it's OK.

> Change-Id: I3d9d570bd473762e3bfbb251cf8abaf5af38ced9

I assume this is from some code review service like Gerrit?  We usually
as people to drop these when sending patches to be included in the
kernel (so when sending patches upstream).

	Krzysztof
