Return-Path: <linux-pci+bounces-35086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7879B3B48B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5617FFF9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891527A907;
	Fri, 29 Aug 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4p/Uwuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F72512FF
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453321; cv=none; b=dPmABW/aEgXUy7mq24/xJy873r4dIHbCSUgmPSXrIZRmlf5Wv2l2c0FU6FjNUloOfmeU2wPhKiDizt/S/qDoUWflENOWPerkBcVYAc6QemRKihM5by6xCP7D9f/PgSlxOq6ai/z3cd3coMd12XIKiPQ+X/sXg3y4rkHr3uUrty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453321; c=relaxed/simple;
	bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCwWDXDF5Ul2m/1eQQjp5cOJVPuJGv892vL/FMWTnO/r++zYnI39HfWzTk/ska82ue1BDuh7gsAB2smfh8Y6Cgb1aiF6NdEybbXIoG9cL1bDRLYFqvDiOoPIkGCgqLoOtFabZgR95+xc0SQ9FELlSaX6SSM3o5d0TjAf1/QeomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4p/Uwuk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso1346258a12.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756453319; x=1757058119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
        b=G4p/UwukEyldIQg2YYha/zQ2wQZlHT/NNQft+eOty3jGx5mQHRFy/Pz4+gWYLggtFA
         pkY0FtPsnXoB91POJNosGl2F7XWu6ln7mpY+DKFBk8OAhiEPNBpOpMA+h+U5cmnTbEWb
         l0is/SMnOrmblgYpy5wbl/NF5p/oKeotYZIrs1agXjSSmILnVzLwZUYOnC2nRI6dQ0dr
         o9piNNw7vaHvBFSKpECU6jMcUo4cyKqdubj2INLb1fvzd7s/O2IdijFFkYzx8DkLrjrw
         8aHesg+HpNzbpIKqFdLVOjeWEvWBYIpU3e+5gYw+vhBV0TLr46LprDftuUacil+xHHIC
         Y9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756453319; x=1757058119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
        b=QCKCkzXpVFm6DOftgm44k3KpyDyAvNR8Jqw4ElyRz8c7OCBskhosC+D+IogpurCiJ/
         bQCukQtPJy8Nc2YmkLdiiMOmK3ica7DLvyHoFJZJF1XRu09JjQNgZhdw1hwxfCds5C2J
         LU88kQd2edR3U8HP7krzxKp1m/RAuNEHahE/Gh0q3BdPUh6bvJw+ECKdU8WNp3YCT1mR
         KynRNIvOPT/Cih/14mS9z59oj2CFAdPmol7ZEbqHnHzCLYxWlWAeFAISCWbFv0TDzDTm
         ELyWKeXj6amJWjTyvIn0DYhXYkr367N2GLfhzn9vwMY+JivPg03rMu9JuOHSWeiphLl/
         5+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5f26qSg30TEN/P64B6NcELiKAl/9gheMf5CIAYOxdsCueKK/bFsICiDUqYIi1SjiIOIoL+N5sn+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXh0zt4v0ZlS2T2jY167LYEnpStcg58G/YSNKPF/jMjKAJw0JE
	AIolDkmas3f1F1nP3v8GJxnILr7K6lrGFZudRzOnj+GiA1ZbF6oolCXv5Q3i0ZHjbLo=
X-Gm-Gg: ASbGncscFNlVNgmQ3rNADOGrAjuxOS/dOYUrbUp4SQzGWUSNkkW91cgX+zpm0EVVw0m
	B4bkFCULRJel2CrXneGxRRK04z9nWsxGuT64YJk9SnZCWrsHNhXi58pOWjxgIX9MODxt8UKX37u
	6pIMjNswHLqBGlr1BS09qIobDPIrqNQRsamzSGuzoARY2h1yWqzbm+nA2JWTpgA7eItZqeRGUtU
	fgoWVKcl3s35YtzuR+stjZicQeYap9vOviGs6sSJPHdPldZ7Um3PvHiN9iymDpTyEA7Wb7yMFL/
	i/NIiZX2z1pm/nRNeCx6iA5rCpGgxxpBfBx26nAwnFipc9drjbNdCE4h6/zbq1EweImr+WuG2hg
	6j0d246hCDxBTJgTvsFnjHHugUzSd9A==
X-Google-Smtp-Source: AGHT+IETAkMl/+/yPU+PyfRIWy19cUVq/UQ3leWcZvK0ONU/TNvkUzax0K+V6T4TRMooRP7D0B6SNg==
X-Received: by 2002:a17:902:ce0b:b0:248:9c98:2cf4 with SMTP id d9443c01a7336-2489c982ed7mr129967845ad.46.1756453319511;
        Fri, 29 Aug 2025 00:41:59 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:f8d7:f98b:c2ca:420e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037285b9sm16627095ad.44.2025.08.29.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:41:58 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: inochiama@gmail.com
Cc: anders.roxell@linaro.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkft@linaro.org,
	looong.bin@gmail.com,
	lpieralisi@kernel.org,
	maz@kernel.org,
	nathan@kernel.org,
	shradhagupta@linux.microsoft.com,
	tglx@linutronix.de
Subject: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
Date: Fri, 29 Aug 2025 13:11:51 +0530
Message-ID: <20250829074152.337221-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827062911.203106-1-inochiama@gmail.com>
References: <20250827062911.203106-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 at 06:17, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> > OK, I guess I know why: I have missed one condition for startup.
> >
> > Could you test the following patch? If worked, I will send it as
> > a fix.
>
> Yes, that appears to resolve the issue on one system. I cannot test the
> other at the moment since it is under load.

I have built on top of Linux next-20250826 tag and the qemu-arm64 boot test
pass and LTP smoke test also pass.

>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

