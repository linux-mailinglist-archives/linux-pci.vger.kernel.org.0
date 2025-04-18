Return-Path: <linux-pci+bounces-26210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC3A934A4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846EE1B648D6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090C26B2B1;
	Fri, 18 Apr 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Ixu8ln"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6191DA21;
	Fri, 18 Apr 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964974; cv=none; b=CMLfQMzCqEPXGNJ1DXivmW1Ejx67Z7eNI605G9OctHfyFR98DkyXQRiPMrH2WtbUa78gTAGMJNzS9iOEqUmcNPA41NXCpUrxeBgnvygbLE3GFtEFbpHLJafwaE4I0M3YqioWy+XEjKtMJAtJ1gLVEW2decO7yQ9oK/zGWh9Mmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964974; c=relaxed/simple;
	bh=s92j6pxzvlqV+3o2hee8gDhoG89WN1vgnuclnd0mk+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ehyTs0wrUNzCXknN4X3zt9wNxjOMV28UrQUZDg3vCc54gn7uqSQLMCUaO6UY04AqB6Um8jlO2Ralp2noxN4bFgTB+t+XOq1GrRGRSGPKRtpQHIju4DAbG3b6xuUoiQkm0F7hwl65Rj1020TLSiHk4IskekYW6R+f9Pp5LB1K81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Ixu8ln; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549b159c84cso2086811e87.3;
        Fri, 18 Apr 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744964971; x=1745569771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s92j6pxzvlqV+3o2hee8gDhoG89WN1vgnuclnd0mk+Q=;
        b=G0Ixu8lnu1iqlOTLMwLa3u9p6orBujj2XUA9n25sGYBwXBhfQD+bYaMYeCD2JZE4Pt
         eVXhgjLDo9LnKnq+RhDCxfc8OB0DtTj1HuPtGyEMG3zwh/y0P3OHco55qtRxPbuOFUtD
         cD8V0BUoRqJkYGXOfON/0xz9YxyrXgsoVJecgbrRDOH7rCaZR5Cbs31nMXGlfLg0qi0z
         yQ7hkcATA5/jSJ9brr4xstuK49UcRtJlW+t4qZqrkbjdLCiDCWs106PEogLHAK8DiEL+
         ReNVqgyZVytFZMrJXORCFlnXY9xjh6w0QWNI9SdSdsS8GkBS1udYoq5bU8SfIogMLwmC
         MoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744964971; x=1745569771;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s92j6pxzvlqV+3o2hee8gDhoG89WN1vgnuclnd0mk+Q=;
        b=SttvKVr3IFtvxzvUwv0t6DXn0+sppl6EE/d9/Z3Frt8A/Cy+K0Awe1IgsclitBIV8z
         gxjD018XYYXMmS9/NDHgGuNBGoLN51YDeE7jwO00hZUA2MBcBkP1GjzgRg+fyi9TmcQE
         QjdEq2c059itJYokKLppYbI1Pwy2hI+R2trcEGg3SY9ya6mb1BULfOfpYh7N/9cWVDdx
         fd8xS5lPzg6I7dIDLydN/LmpaxgKu75Ei438B+tALOHrQu1eRE64oQ3r9dsJ48E3Lc95
         bujp95kcP9zN0v0ZcIQrS3tUrbw65mn08hbG/e4stnPz4OpqkyC3rzWicHdIxaCTwlRu
         7hcw==
X-Gm-Message-State: AOJu0Yw/5PNcrrC4/ttAGKJ2nUY6NzK1lyY+RG97ZP4xcJrPxSZDIdN7
	/4sB3kv8vMQ8070UVz29gNuLUgSJbOqsontkDYrsA2MGjeu1eV/bmPJ+Wg==
X-Gm-Gg: ASbGncsPrfqzjNCNrmDsnQwkNeM5EPqkiYbDlAfdQ040qLob8TQkW/5pwTPgb/9v6sk
	qrm85vwxmUdmTLpflOVnU/0+cc9arhFFCVM0qKLe+ID7dY6dvuwCy5O6dHxF5ABxt+pbLpGhlcQ
	vPNwxCtWeoxWHxMmQ9fQk/gcQeFLqu2HvDqCSlNllTTBn9C2z2yelxbtByGK1wJlHmdpSU2rJgM
	WyN70HeQWUvennFUIDLf4XzB6mvTBbRgyFX7535fTN7LsMoGDIVqcrI908fjIAC2zq0KlWD7Jyw
	4wsEdyy9pIepNhyBe+uQmf/pCiaDRU4T4yOsQa2MY58hHmQrKu0DA64eBA==
X-Google-Smtp-Source: AGHT+IFUTm0W49Qs/USupxCHL/NXGEOwE+ROyG8Iv52IIXe6ndsNi4djYlFd0wAdt3CQ7vpCPkN3hw==
X-Received: by 2002:a05:6512:2346:b0:545:e19:ba1c with SMTP id 2adb3069b0e04-54d6e62cb0amr470052e87.19.1744964970781;
        Fri, 18 Apr 2025 01:29:30 -0700 (PDT)
Received: from foxbook (adtu187.neoplus.adsl.tpnet.pl. [79.185.232.187])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5e524csm129527e87.182.2025.04.18.01.29.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Apr 2025 01:29:30 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:29:26 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION 6.14] Some PCI device BARs inacessible
Message-ID: <20250418102926.690ac42c@foxbook>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

This is a heads up that an apparent PCI regression has been reported
and mistakenly assigned to USB in the kernel bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=220016

Visible symptom is missing USB devices, but the whole controller fails
to probe, apparently due to devm_request_mem_region() returning NULL,
see drivers/usb/core/hcd-pci.c and usb_hcd_pci_probe().

Same systems also show a similar failure with some AHCI controller.
It seems specific to particular ASUS AMD motherboards.

Somebody found that disabling CONFIG_PCI_REALLOC_ENABLE_AUTO helps.

That's all I know, reporters can be reached via bugzilla.

Regards,
Michal

