Return-Path: <linux-pci+bounces-39311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E60C08EC9
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9BD74E2D31
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E8E2EA726;
	Sat, 25 Oct 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHHvBZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AF27E7F0
	for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387083; cv=none; b=Fc9+REAvxF48GZbHKP47gv06r1xl3ja5kshA7SVsaHd0+FHSHnfp4Ld+C2M8/g8LAt9SUVP2YOp4hDZkQ479ZTUMnGJq9tUC2Wg5PMElIb0ASbHRtZDfjS1r4XUQG051YvOUikjrHFK7UGdI7nAl5eCo0LAL8NYkkMMvl3BC0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387083; c=relaxed/simple;
	bh=0nttiORIlAvHv5WtRRqjrF4cMesKYVIkYZR+vwF8Z9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TP26syTie7Rp+YY8BH+QYPcvSDzZiFPrYTQQfKO4ejW2AYiglP2sST+ZO+GAFQBVRZQVKU7Rd75eFTh0jeyFWJsvRNqon/jdMRxhhGT5DEWc/emooCn/ajY1rKaC6bZp7K8LYoJlnEWyfWmthAhkf7vtWSuAbsMqknkNqgTr84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgHHvBZB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so2232448f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761387080; x=1761991880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egj/7WjRwjT6riGuR0koHtTyjN24c/LRgAczk/OnsWw=;
        b=HgHHvBZBmXFecfLdAJXTNhYeCvjdhSbtWXwrwtx+X5ZNNyDLP+RSAuqKEmG9bLtV3t
         9wHEvI01s+tYTPBp1Lx/9B72t1DmN5W1BYhcPfVUY+UgTsr4YBK0mBtKr4ks/0LEOFST
         QRcFOQ5UuN/ZERtpvcrTJB5FtG+xSQkywimig5R0n71+Sv9fsYwGbxo11A5d35gj8sN/
         zOW80PraL51kr+eudNgCruntRDDyfRRR7uJIQxPax7+JuL6xU0g6Mn89HM2r0RSWmqK2
         QDMPb2gJk3llajzDXoaBxXyG+AUxwm8eNyH6xFEVOaZObnd8wvYl7pikU/o8MMxEUvkP
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387080; x=1761991880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egj/7WjRwjT6riGuR0koHtTyjN24c/LRgAczk/OnsWw=;
        b=Nq8IjUUvGL4ByLbqDSACeFu690ZURT+i0FKahfNGbY1nnga6jCPJNjn2BxjaFlNw7c
         kxg0JfXULH11E1TyQrIzUkUYVcoBEKmod/DoH2kJyz6WtXSYY1DZcfhV4x/h8i0Q3N+g
         tXI0hzGkqBycP0FT9WdEQ4jRtrUofiqNVPrY1cZ2b+v576EvgIN5kfOrLtkfKreMPLq1
         YFPJyEK5IFCI8nJIesIJwczUEaC/6ZNkBkEPDCCW7/+grSTzVMWKTZoqgvjLGiAG/f7k
         wPlH+QLqd2RA1YWqiu5QYGVa+80XcglKfxtrkpQfhHWF0PiBCFD3J99OJN8qkClVtJAN
         +slA==
X-Forwarded-Encrypted: i=1; AJvYcCW0EYuVyi8a4wxk0ZLddLhPCGUkA00DPti8W4Y/JZ6wceGf2wzSERSydWk9KEjcgMIOH6nV8u7s9OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwST1CjZluXctGUMAz9WHdJNHPoty34jdkeDH8NgHJaLP2Byi
	USaliFvdww83scq4Qa8ZYkd5WReb4C+Q0Et/8Tj3Pe96vQ/zACFY5ShB
X-Gm-Gg: ASbGnctzfnYfoG/t90ScAOFKiQfaySI7lG2uOX/jL1x2ctwD8MhrYOqXd+VNQ5dtqrr
	Bg35uShjMDbzz16Y9H+bs2jHt6LJb3uH1aI/6HTh9YKYXDpM1mSU3FgFC0WAdlCCz5QU4eDbrPy
	OSbM2RTpqls16vBpBJvbIifdGSnqQBEdvXghAHgTT/YLJTW/CbVINSb3id41kFrJyF4IiGK1BbN
	jbBVgD233ATrdoiYqGpNhzmCfA1gJUYfilE5Q0FqVHrphDP8OoqQdYw8P7iyVvSigPMSJS8tj76
	fz+8WZVySDxAsyOlk7/+41I4y50xqAwq7ti7j6lAUYzYEL7m/xYLqefGkipIvzzuboz9zGVtCiV
	CLtrsq9U3E/sTMie+w4H7VauJVOTI94Gkev09wodk4CD2DqAPsuQzbURygtxe2oSxpw5XhPsisu
	KxbflcbXtU4Xu99tNUaLF1krG8TiVAuz8sva6uH8O/3aQkxq9IytSENe1CyQ==
X-Google-Smtp-Source: AGHT+IG7ABSr4FtdNNEAo2tbvL9ho+vuY3QRO6VXg6V+Dbe1PORYyrFkPG6pems45nomzqTI2u5v4Q==
X-Received: by 2002:a05:6000:2911:b0:426:d734:1378 with SMTP id ffacd0b85a97d-4299071090fmr4006603f8f.4.1761387079673;
        Sat, 25 Oct 2025 03:11:19 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:c4ec:4cfd:1e64:7a3f? ([2a02:168:6806:0:c4ec:4cfd:1e64:7a3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm2915027f8f.9.2025.10.25.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 03:11:18 -0700 (PDT)
Message-ID: <990fe39da66ad23df4c85ef247b274a0fc6c2336.camel@gmail.com>
Subject: Re: WARNING at drivers/pci/setup-bus.c:2373, bisected to "PCI: Use
 pbus_select_window_for_type() during mem window sizing"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date: Sat, 25 Oct 2025 12:11:18 +0200
In-Reply-To: <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
		 <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
	 <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-18 at 10:14 +0200, Klaus Kudielka wrote:

[...]


> Device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
> PCI driver: pci-mvebu
> Hardware status: The joint mPCIe / mSATA slot carries an mSATA drive, the=
 other
> two mPCIe slots carry WiFi cards.
>=20
> As far as I can tell, hardware is operating nominally, so the warning loo=
ks like
> a false positive.


In the meantime, I stared a bit at the logs, and at the code.


WITH the offending commit, I see TWO identical lines before the WARNING:

> [=C2=A0=C2=A0=C2=A0 0.027107] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
> [=C2=A0=C2=A0=C2=A0 0.027115] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000

So, this part of  pbus_size_mem() now seems to be called *TWICE* for the sa=
me bridge window:

		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %ll=
x\n",
			   b_res, &bus->busn_res,
			   (unsigned long long) (size1 - size0),
			   (unsigned long long) add_align);



WITHOUT the offending commit, I see only one line, and no WARNING.
> [=C2=A0=C2=A0=C2=A0 0.027405] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000


This behavior change really looks suspicious to me (maybe resulting in two =
identical entries in the realloc_list).
Does that ring any bell?


Thanks, Klaus

