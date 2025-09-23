Return-Path: <linux-pci+bounces-36824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94342B97EB2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 02:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2747B195C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A11A254E;
	Wed, 24 Sep 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="YWw9ySG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB019DF8D
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674594; cv=pass; b=KRES1z9e1ZHvcI9vKN3bndzYKMl8L8toix3WkZwJ1cTkHUjsf5m9AvwVEdQ+NVIt5HxCo8QRKP5tW/D1/IJgLr5bkB2GDeUnkgItlAhbpYHFjIFGPRUatRBsqiXADYwIkmDfngVMwQ9OvVK49bkpr5281TGnEgaNGJJq+TQ6BDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674594; c=relaxed/simple;
	bh=aoNNPfKPv1nQCxMUDWRRco2OCSqRNAmFqAOXyKDLe58=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=I8XICTluPLGbpl11CxuQAAGBHJZftZVm/WnkTEAoYQpMJUAhNEbeuVnYcMkuO5A2q+7Z7q0kqjpt42GfMVptXZd0p7Od9F1Q0QtELmlSZQew7rxA0V3kM4ftyR4Az0vCyTFSiKAuo+anlWGsAl/tPSd/PIVMoaXhewMkzccM9pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=YWw9ySG3; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674592; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=VHMB0HTf7nW6jvS3KHT3Jb+ojt7mvhwFMpsu+6NUMQPrHRdlhfLTIrdIDkNCeIWvJwW/Z68Wvnbr3maE8XKxh6onQnmLwU5LxpQA/Kn+ttPw16WS0n2YjvHM9+cNUMsreye+W3mRjzPN36gsbgjBTjdAgIl77PGCcRkBfIhXXEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674592; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=aoNNPfKPv1nQCxMUDWRRco2OCSqRNAmFqAOXyKDLe58=; 
	b=t3J7TzqJtAQ/5lzqzxjMv7AFvnvRwbglMXVgo3BJz/UmiX9Sy0TuaBY+QOxp1WriqB+wt/LBpc5ljl7gWNW7CR4tzpVZAqa4rf5CzKmK0CPLAP1X7CfdQIuS+5eFQkI0qgaxAjE0DoAK8FfvvhBbr9ODKZwom/tW36ZNE14sfqw=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aa09b20-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653150821.1932103067533;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=YWw9ySG3SZMtvlOlkbotGbHoPmofQxI8YgvvAM4/4gMGP8U78JLYfhrZgyAIJIlfbNQgY4eOWBy6iBpma2iKIqVcMsQk8LHBr3fQzT9S6fwDo7nWcNe/oCkedriRrOguTUTurYjTFXRLuEUcu1C7X+ry8iLdiWZmGB+WEe8joc8=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=aoNNPfKPv1nQCxMUDWRRco2OCSqRNAmFqAOXyKDLe58=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-pci@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aa09b20-98d8-11f0-9ce0-52540088df93.19978ffc5d2@zeptomail.com>
X-ZohoMailClient: External

To: linux-pci@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

