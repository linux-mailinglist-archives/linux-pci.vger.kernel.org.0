Return-Path: <linux-pci+bounces-38470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B7BE8BA6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317841AA4DDA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F3331A56;
	Fri, 17 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="Q7njh6Bm"
X-Original-To: linux-pci@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388D342C90
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706311; cv=none; b=IzxFEygCq736+wXLBZjUCM5M3C8ChkpQTTww8VnnNXkor87rfzJ+QAXyoLN2iBaq3gu76dK1jCJ7utcdBmH+twakeoD9aFji5OG20P9pFM66aPQFVQGCYtK3414KrD3KxdbwF4S93+zQZpLJA5VMycUu3UaofLiBzMOUZBc7OSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706311; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvbzsIpXdoJw2Wb7lsvZClzhO+mnDLYxA4xytQjMXf/ipJhfDQdjqNltdl3GCRB+L6ImaB7xUNThknkp5CUIz9Ia4KBns57VJzMTfxjFPyotBXnd20IZ5k5o8In56uS+NhUT7CRZnm8WUCpHA2JULDNBjetoDwvDGpQ2Sh9shE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=Q7njh6Bm reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 4B22753386F1
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 07:45:34 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705134; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=Q7njh6Bmgpq7OfANpIELaC8biUkPpYDK+LriMZ676vgnv2r4A+7wAna3j1P7Ifoo2S21q7
	fs5EATtZkXmQBGGmbAcfldilR4aU53JaCbe7I79OVGxHE1Y9xLMz/0gP9WG0zMg0PhsrO0
	wJOqjTLg/eEECxkjlutDQCsN9VI7uHvkT1//INIV/v9eqO9S6EW/D5b812nyC+5Nb8av84
	21dmYCDwJ2iq163iCK4lj2gfIzH8csF6ZfGB7083rGAvULte2GMpoGYQfrLnKa2tG892IM
	Ql+03oh+fPedqVYAm2tvpqfUCB1Y0rx+QGy5Y//6/D48o+HH317xIAzophlwWA==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-pci@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:33 -0700
Message-ID: <20251017054533.E99F2C8C9652A628@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

