Return-Path: <linux-pci+bounces-19224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3BA009DC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D793A3A3FD2
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A71547C9;
	Fri,  3 Jan 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZQBuxIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5665A47;
	Fri,  3 Jan 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910444; cv=none; b=Tz8KnxBQLidG25sLVhjej0eTc5jNpYKOGkSf8kVxDpMdYyw+4+Su82AVDxebnXKJpA39ie95WlRW4TTvzpCEQyZjN0oPya5DYZZRx/TfzSijOfSth+At8Ri88TXMSJ+gW+ddizrGSsLOzuZ23hUNuQJbnVTRWd5m+k5t+vPuCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910444; c=relaxed/simple;
	bh=/W06P7Yap9ayunUulBu82k8vn3ugY5M1/I3mLHIlNQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jr/tOBiV0krwOpUbAoF1McnzIVJe6iRoKhQGXOvMAmG6egi3pFVc78dutLFNqngAA+CCXXWUpDPGbIvza4V7Ld+PyGAPkWXy4SpTnb9tMdNG6Vk2GuKQ6PDXFsDa24G4dCYcQJGm36ap6/+Eg3nqUynExLUXu5JCNU9b5uzFQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZQBuxIt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so213603945ad.0;
        Fri, 03 Jan 2025 05:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735910441; x=1736515241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W06P7Yap9ayunUulBu82k8vn3ugY5M1/I3mLHIlNQI=;
        b=NZQBuxItXFQYP+y9AnIO+4HuB/SOgTw9QicDQx+zpqOy4yLeTvC4maYlgrJEB20n4u
         akarXUrzFsmkwMChkrD/PElz5eJQ8E3UyBD5LLlpQWFAjIGttZbZIfLMF021rKvRhQ0a
         T0TmyuCeDWu642UO7NzJBT4vWJcSXMjS2u/jTLmNrYFAu4GkUI82fq218WmgAvbN8uqx
         SYgYMEsHtQsm73rsQhlltEH4ttUAg4xl6UxhQBqGVWe6GeiBUhdvemaHbHXqeKNYVB3e
         kTIKI5AXjDWXRedgf63NjbsD2t5jxFaF2SZUGok31LfWJF+zF/SCx3KxHyHph9LdNBxX
         7TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735910441; x=1736515241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W06P7Yap9ayunUulBu82k8vn3ugY5M1/I3mLHIlNQI=;
        b=DHc/PqM57uyOsJbCIUhWCsl9GF7LRpuTRgdSFJSftKTZasXjP8lk/00ciOLHP74HhT
         emtUcE7Y10/8F5nfVE+hEMFNnGt5iQjZb9wRAP0T1jZIb1q2fMfX176McbmzYY2F9rrh
         SZMVrPzXM7ObKxSSpSWkAwKsDsj3PEldnGjBmgwIx9AIrqRw/y3NfZQwpjrPv/04MThY
         hp1i02qtoxxVtfZ8vv9PkyaSfiK0qZqGEjD7tExWfct2iLy2QFSSj3yHUBOWGOFqonN/
         IdyP4E6jnEYfNnqwPt51BW3++jK3WvnzSmrg3A99CCpKZzdy+TWj99qpeajc0WWLRkCk
         22kw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2TQ4cufy7ymGRDkb304lqgshRMtcCn7V503Gt4Yvk8h7JlgHvSEFtN/UWo22x9QLL/Zb4JhgZMoNrek=@vger.kernel.org, AJvYcCXwk4b7oDG//29ew3RRaxm+N+QRe5p8J5wCj2qiwR3hYf3v3o128936G4BQlW7BdNtl4QXJbUZuW1BR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Pv0LrhSSlsY8lM/YO5I6uUR/SHSBqw/gtQU9RJp7USN8jWej
	IMOzV47w37oK9c/glzoSgMze+frPnVbOKcEEI4N8GfyDkpPNSb9j
X-Gm-Gg: ASbGncuq8IDrsiUBq7CpABTdnyjGUIA4Z/q4xqJa1WiAK9t7dM8REuiHXG4nlTNoweO
	Ph2H7+Urqd+IHkAT+tAI+NF7+zqtM9CTIvCJJPH+WBCXgTdsaZWccJjVfD6QHJwrxDLPe1sV5GG
	EAfbUoE5Cb8eP4a6K7sofelaQ5aDWglwxb41X+ve1dX+WmCO3vNRmM7t6PWr90tqkAEvunSoLuq
	Yjc4pXSILk0Y9IP9iVol27sKLInztlXaGssVOKFl5PZiz84n0EgRpz7PAgRtzRBRaI0Qr/ezWc=
X-Google-Smtp-Source: AGHT+IHwExdimclmMSKacLQ/hGjwUiFfHmTo6c6idhsY3kVPOan85IX/4u7Qvp+eCIm8FUdgIGDBCg==
X-Received: by 2002:a17:902:d2ca:b0:216:393b:23e9 with SMTP id d9443c01a7336-219e6ea1b9fmr542337925ad.20.1735910440998;
        Fri, 03 Jan 2025 05:20:40 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c80:72c5:3bab:4abc:8bf1:8fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97181fsm242842355ad.108.2025.01.03.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:20:40 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: evepolonium@gmail.com
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com
Subject: [PATCH] PCI/AER:Add error message when unable to handle additional devices
Date: Fri,  3 Jan 2025 18:50:35 +0530
Message-Id: <20250103132035.1653-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227071910.1719-1-evepolonium@gmail.com>
References: <20241227071910.1719-1-evepolonium@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i completed the todo on line 886 thats why

