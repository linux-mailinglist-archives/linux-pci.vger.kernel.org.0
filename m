Return-Path: <linux-pci+bounces-18405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFA9F14AE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D61C188C9AB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2A824A3;
	Fri, 13 Dec 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+lSOY/k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EE184528;
	Fri, 13 Dec 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113222; cv=none; b=ea/gFK1Zz20MENNvG0WxsqrGY9AdDtRmOQ+cvinfic14YZT2t38XBFRfHHbAijpEYJro0CQ5p/RHm6PbWsR0lgEdRMnm8ZBWpMFQ+11iA6E4/sFSE0u10Q8pEvGwoHl3gKBjEhE1zAUzLOY7yostXursC8zrBc1n3cl+L/WTR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113222; c=relaxed/simple;
	bh=Q1jtpnMoDzgGs3o8AT7MQjhuAVqmcY5kDZWobHkOgtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAYKIi39zvdSQkzyZECnymg+2s3QSjShaHLhX+oX0l1tgpEZZirD1CYS7eAMepr84sZquDR4w92wz8b70aN5lhIehWjelKTZOz6wBLA1YJp28zivt9T7fwV3f8ZqglmeJuzdsjYI8D7ekUE8kA4bSk1u/nWGHFffwRAKjS8M6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+lSOY/k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7273967f2f0so2238735b3a.1;
        Fri, 13 Dec 2024 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734113220; x=1734718020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waSG8iNGNP0GQUwPcZS19auffK4ihcyQisgz3+gVhzA=;
        b=B+lSOY/kB8nS5uVKbzy08BIEKee6vBfJysSNDOGfHvcLe8Y3enLq8gFfFBSiZJCoS+
         ByvpOThGZHoGrC6ELTQWmnyrOkXZ3+Tu58DfVwAoU3p3QhUnCXplbu5b1JOzqERumOpJ
         nxOvysJQEtoTQ32wzErjXxpfcg5ICl9WzIDQTJxiHQeLmDSBY3vCeyTnBhaSMyF6DGft
         7UoPE+EutW2rkHAhsSL104VPt0rVN6CYzKn1oe57zfd4O+cL28gxBOQMBWSp/XP5gdeR
         ZOuGjiG5rGNuyK9/dkOOmuDs69aiH5GZ5pvxiE6T9M1wBT7WKPsUt4GP3WoceVk4lI2a
         U+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113220; x=1734718020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waSG8iNGNP0GQUwPcZS19auffK4ihcyQisgz3+gVhzA=;
        b=Ak1BnF///nDywqVmPwz656Ab3PLVteww+TEOkQILgLJo0FNesSVVyLzvRqUffWlgra
         2jKIk3MyaDh88kwK+RBXtQRIcq9FlDa8/a8iJle0DsvWqxAD7rREr+7XMw5xLbGoVeoD
         wcdF9g25mRuqGJNNb34pnLhQNoHfc1qg8YOKApRxHWPXx+pxKpJ2H6BJxLY2tuzcwV7w
         EJK3wOOE7HvWoOBxXoveFrZIEb4/d9FwI+Hg9rFlyPUohZ/UEnuyxwTpkyeJH0Rsq02z
         JrC44GNsOR2G4KuemBnNvBNORiyIPoLlfqqxepMM2Fsko23jD7Ku8ymt6WK96COAojNI
         b0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVBL/IJWJvpIiO8JCohQj6x0fgwfvNhFdbdCyYwkqvggxHX3jGeOOqAZFFpDMQX92A+ByHwM3P9cO39@vger.kernel.org, AJvYcCVKLjL1jNXXK8ncdtkp3lubjZ7fAxwHKhIrldQxdgtXNGR9swTGoP960s88MACAWmjYBf/hDxb3+ldXrzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2/2vlIkwEPyQHCfEwDL8EoHBuQQQ0RYWa3WMMcceQBIkbJJ3
	3QO3T262jtb8GFgwInJi0F1obK/fcQJavn2NZwC8zpB8+uMJlqYd
X-Gm-Gg: ASbGncvmAicUB/LyTXZZbIegwUJm2ucOAN2/q92v4MPYmiEGspoJ1Oe2yVnqN5ulL8P
	GdQIeknlqF/SBvIMZB+Okg2O5j6Eu634b9ki9yRFpArqgzqHAkee6fasiVqVS+pYlwIKxtcES9+
	pb+D/RTi5ttqbQthmHPIaXTP8qsa9+Hdhs3WVnIVXTmxWxqgmaDnGN9SjVjQ0TRXEu5EZ74G1YY
	9RMsdd41FH3pgPjXaJa+Jvi9vzEct+z4NqZ5KLPWWMblJ3wyq0tcxwbwBvK7QA=
X-Google-Smtp-Source: AGHT+IHXrMEbCtfZFS68lG4Wfa4TaCUn93IdpAD/peTQtuNcTiz934nBgejo7JuHpJjhmPpj1k6p8A==
X-Received: by 2002:a05:6a20:9c8d:b0:1db:ec6b:ba13 with SMTP id adf61e73a8af0-1e1dfd3db68mr5509087637.12.1734113220570;
        Fri, 13 Dec 2024 10:07:00 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ab1efbsm21421a12.28.2024.12.13.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:07:00 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	namcao@linutronix.de,
	ngn@ngn.tf,
	scott@spiteful.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] PCI: remove already resolved TODO
Date: Fri, 13 Dec 2024 15:06:53 -0300
Message-Id: <20241213180653.806768-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213165642.GA3417770@bhelgaas>
References: <20241213165642.GA3417770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bjorn Helgaas <helgaas@kernel.org> wrote:
> I don't quite see what you have in mind; a patch would make it clear.
> 
> But the cpci hotplug driver is basically dead.  I don't think it's
> worth doing anything more than the most trivial cleanups to it.
I will make a little change, test a lot and I send a patch for this. And you
can see that this patch is good for kernel or no.

Thanks,
Guilherme

