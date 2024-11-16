Return-Path: <linux-pci+bounces-16963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07DC9CFD9B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 10:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC05B28AE1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE40192D86;
	Sat, 16 Nov 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILJKafl7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECD18D625
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731750162; cv=none; b=CgGzFgBIpS3UpfldeiwSRpQkwDFEn21wmn+rgq/nRyMTwuOy7Sor98UlGT6zll7ND1DfGJAW3UBz4prqHRTC3/jjluZkmTfUViXpmk+5xdvu730jm59jvseq1q/y2py7UaoxDDpxsRYBwVTZKHUxUt1pjB0a9cRwJlLbFcTXk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731750162; c=relaxed/simple;
	bh=ely5MYTLzQyvl+pvU2ClCkiagUqSAlSeX+ke/ZVqkqM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rH2G38DFAraUPpO0L44ZvDqY+GDj75weIBqSnuGCpTx3lgdKtZFP00oKgfjczap2JIJf3/g7fI0ttph7sNvr8GvepF8f+h2nrEC8TuJAH5FWcOoSW4JPMzvwvfiEkgsu4f3LuR/njeoZoxUCtR5+EXEN4ege5SrZxZtZXYR5HcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILJKafl7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da2140769so359033e87.3
        for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731750159; x=1732354959; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ely5MYTLzQyvl+pvU2ClCkiagUqSAlSeX+ke/ZVqkqM=;
        b=ILJKafl79c9J9lRG1JiHQg7fTZLZZPbEAl3k9QDcnxbFBUzFEK+nJpl8FJSnpZXGPO
         zf6Hbn/+9UQgiKuOwVPNaXkDEU8e87sXGtMtxpqygR1nx56dgsOO5/0KogwgGeAwgnBs
         SdWWnyuu8cFtAJhAn/3GIF0nDC2w6iWhbs4ar9hDhDpnu/8x0V3Z6yOIM/ynPwIYPK3y
         LnCjAPwJCEj2e7csEdN8Qje8sEjGmH3Vyk6oarC7Gl+cDCnPucSjgvK5fA+YSephc6TT
         j4CcSHFJuEF9OtPA7sSL1bNdIfReHrpUeS54WutpQrMMal+KR2dg6bPyaZ/dZFexrGbq
         qx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731750159; x=1732354959;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ely5MYTLzQyvl+pvU2ClCkiagUqSAlSeX+ke/ZVqkqM=;
        b=DFqQtpPMoWNTSdArnYezDkKfd1NO02SUbE0nYaKQG3qT1/YMt1i6khUYJEphmZmDdL
         AaSZV/jntPJuVCqU/99DNCxEydb+7MPp39QUzlwBZUeL81GWgbkw6PVrvE6g3a2lUvh0
         aoBd10KWk3SGHtTEHdSfZNIitSnpnZteGHzt6dB9AEt9GC2UzVQo0bCiey1mNi29oTkh
         aNt6+FH8ENF7cSNlE7je7fxGstmwG0gLTZCUnE42Ol5bIxaoTB4AGDrN50SUK2lUS1Dp
         embI3kwCoOPaT23cFKyI/DIDTP+i1/4OqccVNoW5ScEO9asAgIYzRYCzCaVLjLHi+xtD
         tzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg5JdCd2p9P+ZKIDqICtHG998DXGv8QhtmOFWRLclb14Tryqe70evmGmmtbHAp20oNSuNLwJzb8PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcTA8yAsMVaQEpK0ltfxO9MOCMattqejruNmSrllg4TG3ylpm
	66kdzRpZYr1XW9IHl7PC5cUxjIW/P0mtiyLG2V0j0cYTT2fPw8noAstdPj+EB1n+scisLgRyFDy
	HXy/yhq65cNJa12JG0oa4b2H7RrLt3uZp
X-Google-Smtp-Source: AGHT+IGUWBWfvq9M2jiG0ZpYLocsgxY6rUK8j72owtLTT0ESnP86jLUUlFLS0T9IFp3bU/r6TmKs5X4kfMZC5h4kRMU=
X-Received: by 2002:a05:651c:1512:b0:2fb:2980:6e3d with SMTP id
 38308e7fff4ca-2ff6068171fmr23408361fa.15.1731750158979; Sat, 16 Nov 2024
 01:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 16 Nov 2024 15:12:26 +0530
Message-ID: <CAHP4M8UZ2Yxo+M2vP8bwaN5869HN0rrje2d+gqe7EPghX35OCQ@mail.gmail.com>
Subject: Query regarding mechanism of reading-from/writing-to PCI-device from
 kernel-space VS user-space
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

First, setting up context; kindly correct me if I am wrong :)

In kernel-space :
-----------------------

*
We use ioremap to map a BAR-area physical-memory into kernel's
virtual-address space.

*
We then need to use *special* accessor-functions (ioread/iowrite and
friends) to ensure that the I/O is propagated through fine via path
kernel-virtual-memory <=> BAR-physical-memory <=> device


In user-space :
-----------------------

*
We mmap() a sysfs-file, which causes the kernel to map a userspace VMA
to the same BAR-area physical-memory (using remap_pfn_range() or
equivalent).

*
We then use *vanilla* dereferencing to read/write via path
userspace-VMA <=> BAR-physical-memory <=> device.


Now, my queries are regarding the usage of *special*
accessor-functions in kernel-mode, versus *vanilla* dereferencing in
user-mode.

a)
Firstly, is my assertion true? :)

b)
If yes, then how is the path userspace-VMA <=> BAR-physical-memory <=>
device possible via *vanilla* dereferencing in user-mode?


Will be grateful for insights ..

Thanks and Regards,
Ajay

