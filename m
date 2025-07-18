Return-Path: <linux-pci+bounces-32483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA21B09A3D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 05:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80F53A9703
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4517A2E3;
	Fri, 18 Jul 2025 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SCU5+M4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33392D613
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810415; cv=none; b=pLEVxl+0MZ9PKgjD6CibvONF13s4A7Is/leyd5wtwXSAxHO0XNDfapGjeNxrvA12vbkAUBnSTLc/4EbftC4cNtzQhptK6mHnzdsQEpn34iGB+mzyQ2iebRnfzWnEUEXw+uIDqf+T9AqaZ2dl75Q2DIG454YFUeGjKCgDMZ4faQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810415; c=relaxed/simple;
	bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCo7ecQmtFu9V3OX961WEhVGgKgOaG4vVOEiN3eqweHkKg00IBaRa/Syn47Mqzf7o6fYXYmcfDA4UuoefM0WqJX2i+xOL3nieKPqPS4jn3YuXhfyCa/zsFt5lOeE1MdfTmegXvBW8HsPWr2Iej4H0iI2wEkXw+xBy1gzAZcMDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SCU5+M4o; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1450220b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752810413; x=1753415213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=SCU5+M4owUAq67eGL2xlpSBkeKyUhA8Kq6XFmjO1BLZfka8BYKq+K2rc3Bo9ToKIwY
         rXa23Ds4JToursaj7bEhWeibslzDKQNPDMK9HM55mwP52A+LNWvPuhu52cS+KJm7pnCw
         Y+pN3TUF31U/sgTLEBooIErRvCdG6EXB1KlyT3JZZkBwIyXw0y/HkjBkUlRDj48MFEjZ
         g9hJxDdDlA695w7GTsRlviDeMJzVfasC4u48WhwQ/I1JCI4ZkvuV8ozlFgJh8fl1j2NA
         Ku2F66+xxyXEupdjqYNtkdqa3JMYqYPyA38a5sEuX32XOVMl5ZJi01rjj8Bo3ruXNfbA
         6s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810413; x=1753415213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=VWUHx09WolmDu8/aV/gAS8+TKcyM65yoTzcDiJeJqvD2FDpq5gvJTPUfCauT8M1T1K
         w+EYLrqxPrtB+grUboBZ9VCCVRvhvY4QU8+2RgwayehDOAA12mUaKTcvg1EnOSQOYmuF
         +1T920cVF+wclkbaT/NWd59xhdqn+IssOTOb1p+LS5NzRnNM5AJKGH4IQyCzVLIUwDuO
         dUatLwq/fYLnm76ySS+II3o8rBLnODcNwx76NMhJMe22bWchMX0wMooxmZeiyrTMi0AX
         B0qG4Y1o4Gx/CvbIO7CD6KnA/LMZCxDvRnHQdd1sWjaMS2q7j5s4TIZNlFIGiyPsEg+B
         bSIw==
X-Forwarded-Encrypted: i=1; AJvYcCXldFhO9q/tWCJVVLifhN+qeYl6RqHXymeypSkKgij8kN9CAI/yEmbehTN4De4QJf9FX52CRXQjP2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaUTTe/r4sk8JaiGuoEw3l14gjS8FV/tjNGvN9ptxxlpA0Zwx
	H0zMmc4Fyp3nahyXO3SnxBvtdc0wCwmRA+jdr14D1yC1jzfwkqb3m7W5ZPPYO2njP9A=
X-Gm-Gg: ASbGncsKC9iXLUInDZ/WV8bdYeb6a77KbiTGSRc0PZk2l7b1Zx6sWRrbvnH01Ps0c4x
	oRW6PVnsX35ID8vNnEaA6DLiQv8/0uYjo4YQ/w0pUckS7SGjb11WQH5/9bgCGQujEedd7jCTpLO
	IoeaRquUULO7f3cpQ/7n17OtTDmmfBNa1FIP1xuLbbL/xaAI0dsoeV+tS73CHD+Cq0vOVhLplA0
	w/wXVh/yxG6/DIvbK1fWIERZiMmkc+SM9FXMCeoNa4t426p43aTnt5/oFuHQTtwEsK3lEMrGE+Y
	W0qStwF25jdBv1a5D4PUd3os6QlE7t0WLVptyodSWbR1fIjvfLe4uqTl3998LMtgssi9Hhn7ab3
	BUgjwX0quNI+EVMntdJjW25pFvq2HlhugSKCCINF0PxBIknaA
X-Google-Smtp-Source: AGHT+IFNa+EcH83FNXnjEm3C0F6TihGjOc1OMxlRUqkqp/V85onlhfwD3tW3WOOTiHm6RK2tC/cZPA==
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-759ad4002fdmr1963419b3a.11.1752810412983;
        Thu, 17 Jul 2025 20:46:52 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-759cb678d8dsm310811b3a.110.2025.07.17.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:46:33 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 21:46:16 -0600
Message-ID: <20250718034616.26250-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250717235055.GA2664149@bhelgaas>
References: <20250717235055.GA2664149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> So I think your idea of adding current link speed/width to the "Link
> Up" event is still on the table, and that does sound useful to me.

We're already reading the link status register here to check DLLA so
it would be nice. I guess if everything is healthy we're probably already
at the maximum speed by this point.

> In the future we might add another tracepoint when we enumerate the
> device and know the Vendor/Device ID.

I think we might have someone who would be interested in doing it.

