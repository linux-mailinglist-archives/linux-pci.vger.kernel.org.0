Return-Path: <linux-pci+bounces-21542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA320A36EAD
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C018170726
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881541442F3;
	Sat, 15 Feb 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4UEFGvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349B5103F;
	Sat, 15 Feb 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739628345; cv=none; b=dXzrEFLAIX18n5e43rdAtULp0iwSc0OJ6jmIOGcs4dYOofcHNDB1gXK/EBzKk9z81u7Uix1PKymLZ4y4pL21gnm37t/OThMF1u/D0CFjJrpL6XF8ZpVg3YHvulpWHlUSwohJ/XDD8dm9a8dQdOKHMW6EGxNRsm2QmcyHyHYs6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739628345; c=relaxed/simple;
	bh=ZYjGJAar+VrlW8o4Wdk9AVmdFh+y4NmIJmrHDIUv2oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+/Kvwzpu5j0zyLfm7DrQEBoVPdPSIhbcGOs7YCSArOcc5w22tAogMnFwNiFB+kDL3Vp2y3QkoZ29tfKtads0DQNtfLmiDnZYbHmninlohYl2KMZlOnXcUrS96IDriez44A9lQGj+IpzYA3PXVlrtQyaKOwQC/rTKyHwAVj9RJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4UEFGvc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d398bea9so42260755ad.3;
        Sat, 15 Feb 2025 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739628342; x=1740233142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+vEBIq9kWlXFMUJvEVKmydQ9oi3O+Xeurv2TBEA2XM=;
        b=i4UEFGvcQmHPy/N90PfAmh8AHoOL1dVI0OESRgIYNf+qHQEJZqlZTDHZWv12G5BrcV
         3cM0l2TtGx7awwqNfqshZhTwNMkZUDUsVPzdqlQUNrTjpMz8r2w0XQf5mTNWOYyFkWga
         yuu5sWcK9rh/HxEd4qLQyIEOT1nS9xW2DqZ0jWeOfp4vy7Esg5eQ19o17IhhyWwKniDm
         k+qOy2pOkLVd/5wkDtcYz5HCCiyBlNF2u2Uz2vylF0kvPqOQLw30jmAvP9g6axO5YyYE
         o7CjCniQLeSDb+u2wchtfLLiKPsXV16G3wBpeY4LHKV2k1H3K/POU3Sq4Bp7aSV21xaG
         rpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739628342; x=1740233142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+vEBIq9kWlXFMUJvEVKmydQ9oi3O+Xeurv2TBEA2XM=;
        b=a4ol+tMdzpOSrA2KxxWbJzH/VpUQOs5hGOZ8Limzt1HVLoeIwI28vJv1DNBGTRjFU2
         hJzZmFqS34e5L24I/vXbQJBtG8rPvA4Tz7mp9zn0rrgQ13+FEYvq7PHM3kYp1o+6AGRI
         1eSvkqQI3Qc1h/5R0nxp9z/yBWPNtXroXQ1QmfjpIaDomNBfZ9XGon7aapBhjkuRBQXQ
         6SZ6fnNF3nj6qB+NQOhVYdzxwgDiDadJsos4NiQ5JZlFE44skOyEJh4tc+n/dD9XF9Qu
         dwGJEkqi2LwgyPctUJQVqaAZwpZvppuzIYrAmWCkTmlpmNU+Pgp9PUck4X2NYxrfhEdD
         OgBw==
X-Forwarded-Encrypted: i=1; AJvYcCV10CprvqsBek1tS11ekoKRqzggPwyvyCV69merakv8r2U3XhWCyO3HXGEMEPtrh1xqjUQjNaDDdQxa@vger.kernel.org, AJvYcCV8U4ZcuZbJzhUYXBWRz0L4jpojDIp0fxQufEzxIDbTPDQKGh+RBLemUI6MLCpBriBdGww82f8Ds/pH3zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9NQCbXmTt/9xY8dCBxT7N7zddzpQlsNNlvE8uWSW2fkuCj8o
	z04Fu8dqpKHTeajuXF4PGZm4S0iOBzxxpG69K5wByuqMDQ8hSdx9
X-Gm-Gg: ASbGncsDhjBj+UgtrghL/IhNcN4v5PsovUSAD444gWOLo5QtbB0TCEdIrfSnzFKyZ3N
	nQI4eFeNWb4axW9ozCGEDpnZlyUy4oYdHuvSMSRx4tM2LX2quJG0S5ELwvaYoNsByi0J+qKSKw3
	zmLW7WebmoakroRI9MNVIpN9rBmxqo+A7ieEETHV9S5feXhjT4WvUIFAQ6UuqhEf0dmulnu+1ht
	4P7NtHoJVC4u3w4z2nZVSSKQA9ht1Z3R9mOlJ5xCc2cAzsd6rtZWi924hBtwOxrIakt6GOoXqqh
	6526bGYKI2VB6OuxkCL0yb4Q
X-Google-Smtp-Source: AGHT+IHxcqs+01OksadipCnKxB6vaD7XaLdYOfU7wsj0NnPLTnz8bwbnLbwuY65+SMZKvZRgvHv32w==
X-Received: by 2002:a17:903:2f85:b0:21f:3e2d:7d40 with SMTP id d9443c01a7336-2210403e859mr38846005ad.18.1739628342216;
        Sat, 15 Feb 2025 06:05:42 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b4c45sm6898833a91.2.2025.02.15.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:05:41 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	scott@spiteful.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Sat, 15 Feb 2025 11:05:35 -0300
Message-Id: <20250215140535.301162-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ebf3ee33-3958-43a7-8bd9-fe6169ad6a9f@wanadoo.fr>
References: <ebf3ee33-3958-43a7-8bd9-fe6169ad6a9f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> So, if unsure if the change of behavior you introduce is correct, you 
> should only do what you wanted to do.
> 
> If you still want to propose the other change, you should do the 2 
> things in 2 different steps.
Okay, I will send a patch with only (g|s)et_power() removed.

Thanks,
Guilherme

