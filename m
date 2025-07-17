Return-Path: <linux-pci+bounces-32418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93456B0932F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB42B188778F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8102FD885;
	Thu, 17 Jul 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CG0vGo0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44F2FD5B8
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773320; cv=none; b=rT48vy73A64eRMwulB3egSEHcR8EnUiFn09p4tXFDTzk+VPIr2nn/APmpQPVEd/Yb0wizKIZ7yw3WMIojHO6iAc7r1rUfndfG/NcDTMDg0eY3U0ssK4LjY462wbTKxAUzBnysctZVx0q8KxOvf8od6PwgcEperWGNM6hYsRu7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773320; c=relaxed/simple;
	bh=4EOkobpRITMq5E8idbnypVkSptSvruAesG3OYvpoWuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixYj/MdIQtLewG2YXag1R7EYxMjka9HKW5naVstCeRhe/ud3FIB2SmmbW9hJMYBSKJD6cdhElZc52qapfdRMkBFAfOoq2r06JZ7Gl6wVq/vpOcbSMA+Ia5y7XMgY2jrtgFyOVRIEEGqxLu/0diJSeG2qXbsuMQnbvmrLGYS0GTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CG0vGo0f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234f17910d8so11620615ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752773318; x=1753378118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgUOlqVpVCyyNVLrLuQ7YlmlOUd68fji2oikKoPCcE8=;
        b=CG0vGo0fi/s1DJfuTGkrx96GaHsXoKtvaP9eplBZ37JAHDpaXFs96pKsQe38GMWMrh
         gFOnDWSBiYh14dTdHXDmXOsFzF0rlK66ub1C39quafulc1VCeSzsMJ8cc/HS0lnNjy0g
         pIYW29ida0e85TWUe8D+ePM8WQ/GDfeYHfQJhcSmlvHD3cDmAW48kcTcKmw65q7dxsUT
         LNksY+W1Af0C//HeYz2MCz7/s1hZtcMr217DR4y1z/xd3GS1m3Xrl+CImk0HeT7b2SSf
         9+cGnHdseAjLBxqqHEr46UhDpRrFXRPANHSCpsDUwi7634UO2s4W2NXr5s+7C78w1fJJ
         1XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773318; x=1753378118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgUOlqVpVCyyNVLrLuQ7YlmlOUd68fji2oikKoPCcE8=;
        b=a+euaNgUeAwL7xSNnLE0jFvd2R1yf2Fnf3t0vHKRLRX1W/rX6aE5QE/10Y/lQMEvg6
         J0H4OAZMgANIauLJdC8Q/qXYjMMbC72NTtqWBd1D1B87TekQRZ/aRmiOBrTtrUuhjCC0
         YqfVJ9RwdCCQkWZwhPgHba9kA8T9O0SohKuIZsHvg8ez8r63uK5Thf+Q9H2F+8PbI2q4
         Y8mUSTrvpwWEUpcoI/+qHd0CRwq0NP5aXVU/h3o1V9sU2nhuTY80jmk4gNNromPIygLM
         7clovkz5zEHEDnzh/tPitzHgkkXCLMQ6qnEN1Vfvbuy8C88IP8g8ziwZIY8iRl08w2o2
         Jzsg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXjpl8Ax4zckr1wWHIP29U8HknSA/bywwnNmmcYU3wFbiutP4qV6q8j55VPFh1Po+bspohGVFiQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnMry5EfgdYo+s0daoL4LTr8Ok0/VtJUcRDhyGXT5ozNPVGD1
	yVj+ORK6fB/QAQbH7Uf0rrNqu/zU3tcy4gbLecMZ/K7QF/Na9/4Uv1JNzXaydDUgwxg=
X-Gm-Gg: ASbGncvcF3mgKVj2v7MCGspWxq3GLmSywY4/Ja54OGjBdMDo7LAVsE4wVbbEMLKp+bY
	noHYbFCy8UZKNc9iNM4uL6ZRRhF0M6w4//tZnKEEO76x/Mf82cBI88dxn1B1izUwIlJoTcJynK2
	kNxCBR1msyAFI06ybImJwgAtIkjhsvw2nrT7WTMNir7VZR0c+nx/I105pEj4ZY84U/34AR386jW
	U/ZFbXb4P/qMCkgf66FGHOHsqGw4pt7uCSPEpZnNbih0pwJecBlEeYz+/CDMgOGcJG/NdfSpTkp
	pfLxyhu40zwsUcWbLJIQj/htC0Z+XO7WqcbW+KzseypPBzw/YGiiMgR7J6vD1FQv11Hq8yPih3K
	qixHGtuKtpJDsWM5xOHpIyQLUf9P4220a22lsON+4sFA46QLD
X-Google-Smtp-Source: AGHT+IFsoPVg+KCCnbbA9877FnDOzPGFWoBo9O/Rllt662QL++SQsFnNxRTXWND0UgclMrTHYMzy7g==
X-Received: by 2002:a17:903:1b05:b0:237:d734:5642 with SMTP id d9443c01a7336-23e24f524d8mr105905765ad.41.1752773318500;
        Thu, 17 Jul 2025 10:28:38 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4323e2asm144345575ad.110.2025.07.17.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:28:38 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: xueshuai@linux.alibaba.com
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	helgaas@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 11:28:26 -0600
Message-ID: <20250717172826.22120-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bit late to the discussion here..  Looks like "too late" in fact, but I
wanted to just make some comments.

On Tue, 12 May 2025, Shuai Xue wrote:
> Hotplug events are critical indicators for analyzing hardware health,

In terms of a "hot plug" event I'm not actually sure what that means. I
mean to say that the spec has some room for different implementations.
I think sometimes that means a presence detect state change event, but a
system is not required to implement a presence pin (at least not for the
Slot Status presence). Some vendors support an "inband" presence which
is when the LTSSM essentially asserts presence if the link is active
and deasserts it when the link is down.

Appendix I in the newer PCIe specs say to use data link layer state change
event if presence is not implemented. It looks like this tracepoint would still
work, but its just something to keep in mind. At the risk of including too
much information I could see it also being useful to put the device/vendor IDs
of the DSP and the EP into the trace event for link up. Perhaps even the link
speed/width cap for DSP/EP. The real challenge with tracking a fleet is getting
all the things you care about into one place.

On Tue, 20 May 2025, Lukas Wunner wrote:
> Link speed changes and device plug/unplug events are orthogonal

I guess what I wanted to get at here were some of the discussion from Lukas &
Ilpo. I think it makes sense to separate presence events from link events, but
I think it would make sense to have a "link tracepoint" which reports previous
and new speed. One of those speeds being DOWN/DISABLED etc. Width could be in
there as well. I have seen many times now an engineer become confused about
checking speed because "Current Link Speed" & "Negotiated Link Width" are
"undefined" when "Data Link Layer Active" bit is unset. Ideally a solution
here would be immediately clear to the user.

When it comes to tracking things across a "fleet" having the slot number of
the device is extremely useful. We have an internal specification for our
slot number assignments that allows us to track meaning across different
generations of hardware or different architectures. The BDF is often changing
between generations, but the meaning of the slot is not.

Cheers!
- Matt

