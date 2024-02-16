Return-Path: <linux-pci+bounces-3576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A491857810
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05111F2263F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F41CA9A;
	Fri, 16 Feb 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b="XSFk+wHT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.vexlyvector.com (mail.vexlyvector.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5841C6A5
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073450; cv=none; b=sVO+IqvQOfgS3Gxs82qIIuhTrhvw9wTxNQ8bsjMHQOnBJ6GiRAhSKPW5va12JPU7NqTsN4HO/OxZUDbmRLbmXZa2P6AT6mwaP8sl35VF7NvZck/PVWavDOb7+tWGnff2uVBDI2KoDTcqzpSIrpPaETfo0nV09tGBvEr+PVVj4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073450; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=mSK9NVVYpoua/UwAOiwPdRAQAXQ6aMlvRoQMK3434bzABKWK2tMpIPPCu4QWVW+2qL6B0i0lNPsz1MwgESBb0+801In8FZsdlZyGjpdjqx+wMxvMGC//de01nQFirOdU4uyxSZJbi09ukqD11UplvOKwm2CVe7rmsmsYZoEPSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com; spf=pass smtp.mailfrom=vexlyvector.com; dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b=XSFk+wHT; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vexlyvector.com
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id 36BE1A306C; Fri, 16 Feb 2024 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1708073445;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=XSFk+wHT13SI12OjzLSX3+Qsz3Noa14BO2+vIdZq9iLlhuKhrV6PqmMGXA270JzWX
	 4CAVDGjkxbk4ypmjrD4vN6VOah6nvD1+Ax1tZV01bylF4tQIuZmMOdUo09mpNhp2wy
	 CBbWQf7oj3GBcJvjSw65pWlyzbLcaHsL/n2A8pYK+6yNh8GOIf5oEaqN98LWmkROuE
	 wZkukWPCA4M6177xCxjpYMlGDlTtzvJULKqdaJZoolcwkD22YVEJ6q39iweMilhQOg
	 d5R/JhZk8hucT+rrMR7cVpc9vFi0GDhN5qpUb/PTLNPbIKMFHiIk1uLty855uV5SQJ
	 UsDGNrcpS2oDw==
Received: by mail.vexlyvector.com for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 08:50:36 GMT
Message-ID: <20240216074500-0.1.c2.q7o4.0.xe0jjujare@vexlyvector.com>
Date: Fri, 16 Feb 2024 08:50:36 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <linux-pci@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.vexlyvector.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

