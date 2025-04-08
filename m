Return-Path: <linux-pci+bounces-25497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B3A80EF0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E5F8A5889
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BF1E492D;
	Tue,  8 Apr 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVIeuNwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDF2AD0C
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123709; cv=none; b=sBIzmZEA2UNp1+P726k6OZSKc7mjk1TCj6HIPPiwN0EPlz904UrcHanHSt/9o3akE5ubWHDbxzWp+QcDUxdXkh8g/95VgPaVRrBj2xV+OUynf01vLXa9Cijn/e37sKsmcmvLanUoQfTXu3BhdPZtxwy0yp9o1vc4ldnQ2kRuZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123709; c=relaxed/simple;
	bh=55cQgSO9a4MkOf3pJ6EiY9mcXXFYsCUolchzvWbsKvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mRn80b4JSp5NMdXozOSQUJ+7sNlJ+pV2wDzzVqUNEpgDIr1oAE4TN4eSJdflA8u4dSqLwmUOOmbwSeCCqSvU1p0F2LxDiOsm2q62ye00h1BsNdx/ybBmzOzu8qXgOX9KpFl/cM7aZAHWI10VCqu6eltURqj8Bo5oHlLyftLwxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVIeuNwM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c7b2c14455so3750094fac.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744123707; x=1744728507; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bznJKz6O2SYFzrV+0EKZv488/bcfkz1ahZm7AjPPiIQ=;
        b=dVIeuNwMuBMt6gC6O2974IhLV0lRAyCCP3kM30iW8hxkuYMuiuaycKBxXkCrtHSB3x
         2W5PVF96mlSTz0CNm7ZlbhEWdPUBegtFRfX7pNEc+lPH4OLK5OH9MRBnSSaU4Q7qcAaf
         zKMo8r1XekUZlDv+7piwAOyEvjKJx4MOBBMwUbOZjjpFM5XqQRnF+8hPgbt/1cVtwkJ7
         VasytLheOYKINa4jDR861qv4u9pmQMn7oVxT4re6IEvizmueYrbDagc+CCOojpEF6/OP
         atjy5VtUnLtAY2caVYnCh3w9w0cxqS/OHe7GLlWqCCvXD99Hooi/Oyy4MkaUM+V7lwEU
         LLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123707; x=1744728507;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bznJKz6O2SYFzrV+0EKZv488/bcfkz1ahZm7AjPPiIQ=;
        b=ae8lZv8mmC6rJsgLuglDpT+RDe8E3peUtHWkyrJQPxtGG9NRRiL1j6linzbDH3H7EI
         mvfDoV0JXL08fR+b4v8ANSrJQLPvToNkcd5KXPYzBarTwVElLCA128sKAf1udv9qlOA0
         mi99m2knLdmfw5H5WK9rB0E37ipB+jGQKUUn1NaKJ8oMGX15mvZ064pVaritN2NKWADi
         t1Xf6190cwyTa2TCX0neDFez/zjJeyK8IysDHscDWLcCMGCE+pa5bEDknMJeJk+kyejD
         FLUOJw4TbbZrg7gcwp872eiSY7EE+SZLS/00UtkuSGEQyYc3ZPB+kuOaSA7SCr5YDd0Z
         /VPQ==
X-Gm-Message-State: AOJu0YwEb1zWCijTG/kKZysn9TxZyshicIcCmDcP87gMiRuHCCOwzNc7
	ZKvWGtXQGT8VRcQiK1xLFQ+Pa4xdRBoPWJD7vfsbpp4bk6Wj3sXEPp84p/6giaBvqKrbJ3eaBLV
	8hkfDopFZup2S8FwTRolzdHTYKTDOjl8OrUY=
X-Gm-Gg: ASbGncvoBv0fYBaNzsIUOpc1nBJS68MULgXZdBmriHUfQGW5XawlKqV47vzz9Ptz5fq
	Dq1USORmx11vAT25tSasnBET6+QJBbz7FbPqpye2L2sRdatVbgDw89KlO+kUGSc+g2H+O0hkwuO
	P0eH48tjyS/paXKM1Y85nGgHEQxB83leISvGmgR5eSAAe7ussOjiP1hwXJPoOL
X-Google-Smtp-Source: AGHT+IE27guOwjsKcaRQzKMxApEo8RqcwUOG2X9a0pwVt2ICQ8qZG2qpBPymoLCU2rY0KS4cWl+eZRySU8cezRxjgpg=
X-Received: by 2002:a05:6871:5298:b0:2b8:e8da:e89c with SMTP id
 586e51a60fabf-2cc9e7e59b7mr11444871fac.29.1744123707096; Tue, 08 Apr 2025
 07:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Damir Chanyshev <conflict342@gmail.com>
Date: Tue, 8 Apr 2025 17:48:16 +0300
X-Gm-Features: ATxdqUEwaoodgHRgtuvdEWLC0bxri6HyGuF2SgPjQEzwfMVE3wC6d95IXeXukYo
Message-ID: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>
Subject: P2PDMA support status for the sappire rapids+
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello experts!
First thank you so much for everything.

I have a question regarding p2pdma support, I am not an expert in the
kernel subsystems, please pardon my stupidity.
While investigating performance opportunities, I stumbled with dma
between cpu root complex and pcie switch root complex. And found white
list for the Intel platforms [1]

Typical topology looks like this rdma nic<>cpu<>pcie switch<>gpu/xpu,
for each socket.
Questions:
List not updated because new hardware doesn't support this feature?
(For example abandoned for the CXL3+ )
Or just not tested for the new platforms?

[1]
https://lore.kernel.org/all/20220209162801.7647-1-michael.j.ruhl@intel.com/T/#m3f4e4194770274c2873a130ad684a74469038585

P.S.
Pardon my tone, if it sounds harsh, don't mind it, unfortunately
English is my third language.
Thank you in advance, I appreciate all input.


-- 
Thanks,
Damir Chanyshev

