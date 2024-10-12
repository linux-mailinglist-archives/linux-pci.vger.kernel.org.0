Return-Path: <linux-pci+bounces-14407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C099B73A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 23:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8DC282C69
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57219308A;
	Sat, 12 Oct 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJR5AV42"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106114AD02
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770321; cv=none; b=mwryBZFRX2ew2BpGy+BuJF5I5Gx/5RfgPReIPAxcN0jIZ4N6CuN83fp6iYzNCwDZF6xwqg/4PcSpgmOacN8GZMUo0z3G6r0MuWcSGsScs1/VQP/bWzMU8GRppVqUVrVtR9AZQWG8yNx6qfbtfuabKw1+I5IKHIvtBTYHRM/i6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770321; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=tdy4H+PBzBT8IBz/1ZyCkPd72wTtwlKzinSvsHpFk87iKEGg/gHLBNbn3m0heV7BzkPHEDI3ZkqkYSRYQ7OTtT4ZtEOcUXriooOCAKLkeXiEjbd/naeKHoGZiLoPBHwH2VksM7DXIzhT5zIfFNd+m+l2ock2bG8iXel7besmgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJR5AV42; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-208cf673b8dso33308445ad.3
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=WJR5AV42P0tV12ihB/xewJV3FkbAQESlaaKy7NplMIjtDcNYjNXfuyz2Kxfgh1z7U2
         ejAwAkgpA0+UhHfPT2nnhLyPEuOGqSZCcQeXtD4Ou4rLq35Ab6is9Sx91Ksj4cXytwDc
         Q/2Mx/T7y+WjYA285uVy95siXWVQOyYuPhmzqDHjpP67gHTv1c+/ZwhRuhwrsoRUKxV+
         wIWYKLQtdiqmSE8ndu8DdYnJj3s0WJl6WMLBSKd/mnR+DmVcJQa4RXl2Y6z/NNu3Gy5c
         A3H8aLwE/GV7w316DuwelKeZL/eJhHaufZ7ZiHrxjJ6qet+3lEb5trZ8Q3ponxkfPDFp
         QmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=RKUk8EhHvFBMPya6Ql78x9n5Ixv5X2jxR7yMgBgq3bsTJZzVNdVCqyTovi5Luf1q3O
         AcTuieCpU2wZzx75m9tzOEk4s6mcr0qcQJlZ0CXFaS+Y8XCyy+S18UI83aoOKJ9UWo4Q
         0vejN3FanSNUVTtcC4OqI+g2g2lydigb7dZ9ZtQ4KCcP2KCBFcynPXBZbxFhwyUPRgfk
         DUFcK7OS9f4EUAOnXAbb+UPSwF3bkS3p3CBQdueoxnNH7WGpJZkPSgrPV0f7JFXG+puR
         JfQbSDiXpBrN+8s4LZKmjPIA+avmjInQGMEBGszG/D9OQJ8sL3DMsAv6sq7jp4ZUmEUb
         fOzQ==
X-Gm-Message-State: AOJu0YwBCHXU1N7DYYdPzG8iiV7gxPCaecUEJYqhDVp0B5x7e4Yzp4C2
	o0VjJEamGLgc5s0czbpcb+Dl/01Ju8laqdEno/9lF8Mtkz84K7yA+1R7hm+e
X-Google-Smtp-Source: AGHT+IGBQMfX5NUTFgGNjGrG7PKzScmSKkOuItgN0VR+GQEVbwp+Yku1THGGaqBvtAXMBP0kXsTGZg==
X-Received: by 2002:a17:903:22cb:b0:20b:ab4b:544a with SMTP id d9443c01a7336-20ca16c8dc6mr104833965ad.43.1728770319461;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0ca0bsm41494195ad.96.2024.10.12.14.58.38
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
From: Josey Swihart <oshadaa6@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-pci@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

