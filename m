Return-Path: <linux-pci+bounces-16978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991849CFFA9
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430A3B25FAA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1512E5B;
	Sat, 16 Nov 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUibX5+D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C1186E2D
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771651; cv=none; b=BMRJGcewqftn6wrjcwS1qAJQpfWUlgHXWMhKdTdtVQWAPNb0s9otulkQchHVnfT6tCMEuqpJba6oSpk5/eI2gwLHM5hHg4tcb0hh65YBmgmFFTRcyzvGWxhJ/sco7kvc52FifntKK5M2UPLl/5XP+zahchkXDKMrkS04T+lePJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771651; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=Ke7Ur2RIWnxrk/g1t+/YH/u4VQ2XHSGmihtNWFtvU9EALVh37iM4GEv45W48dtJWzdv+1GeOHCBVFJOyO9ZEyOntT6K24m+2N9ZEZgf2jGYDQADd1YzPwSHsRKGvz/LngVNQtWEwGuHIelqPsYUBQiFdtg1ZYvbc/aycRNbx0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUibX5+D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21207f0d949so457525ad.2
        for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771648; x=1732376448; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=AUibX5+D70Mq04sguSP6nJyPGy1lUy1bnzsA5Gr+hZs1lVfEGxDQI8vkiKif0WyF8K
         /GGqrfGHjlGpVbKEUXL0bKAhlGLXdbwzJ4YfhZoDNRiX0kDbCDXeAu55dPo/3rO2kEkp
         uUWRcQ30FSdgTbZZrjBEDN29QU4gq4VHnK9cKkaruNOhnISeyswQVwY3gn15ywWoM+Pd
         haTGESqMMdDuYmID3mVtJdM9GlZ+V/83FyL6Gn07hjcJm3LW0cHsZNtmMeWeTXag8+kM
         QifGAC91C0NPMSQfw35i8EFeLhKzmAQlRmWzOzJ1xTdpMTNxPe0io8lKdPV2slenNfuw
         kwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771648; x=1732376448;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=mywMMnF+gCRFDuHq+sHAwszll6L3SiGCir6ordZzaJL+Mz/TlBoceuwv6eEMSwU4Id
         0xPMl2Bc0q6DCwNNgy4yje3jprGusmIpzE06n1/0mff6r0DtQQy531DxZAcscJGKERmw
         gjJFPLfmlxHDDyDGY/VYhIS3js9wfvMaP4oNEmbU1oPC1+/6nyWQgbAyZn5EuT2JHS03
         z5SNvbUdwqglzwrPWzoXUe0FvvLylZt1uu1muuOEzRTktpB2Z9va2P3mOFEQaZcOKwHB
         cSkZxfXwpbrXLmpFJKNOOxHCFpPQ9D23i5+wKB4jL+iSc8MsAW6QCDqv9lAQeni2IPcz
         qIKg==
X-Gm-Message-State: AOJu0YwkehlvEZP6TsmEEetTevO/73J9hkej2XAdoiC0RjlLnaRUL3H9
	qBvhlQnN8lJ97QFNZWX/rnoI7N2R/6O07sl309pP945WZ2BPu9+8zr83Mg==
X-Google-Smtp-Source: AGHT+IEbPuYuYWDLhRiRjBJSp+Nt7cPDWnGsyx7KgIlscw6VPDwvfFh8u9mTfLEVevqjZJD/0OMZdg==
X-Received: by 2002:a17:903:40d2:b0:20c:92ce:359d with SMTP id d9443c01a7336-211d0eeacc8mr88284805ad.45.1731771647738;
        Sat, 16 Nov 2024 07:40:47 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f6b3efb5sm10090565ad.216.2024.11.16.07.40.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:46 -0800 (PST)
From: "Van. HR" <harshilantil3867@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <9d47eedb4397c10c284425a1e0f11ebba5c33c1bd4ccca12f274ec7d2fd4d589@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-pci@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


