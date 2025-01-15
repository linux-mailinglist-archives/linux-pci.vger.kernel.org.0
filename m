Return-Path: <linux-pci+bounces-19846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B2A11B53
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DFD163BAE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909252080E3;
	Wed, 15 Jan 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXPefhTH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844C1FECD7
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927540; cv=none; b=mxqXlhCpdXvNLx7Sm5GOeDiqWVqgr0oUon/k1kA7gVEnvDBMmZDt/dBkWDbRsTNq9G8swVs5OfLHWO7bHNPJ6EY4BgHi6ubR4g5ntJpyezolJxRTxwu3Q5dGGA/uYK1ROyJa5l22aVlPghdQ98gVmELd8DJx+HKIRLjZUIE8STs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927540; c=relaxed/simple;
	bh=uHHcojRyfX8w0d2GarvDuvokgmXzp4cSx9BRiUkHQ0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C6nJepyVayvRNkt6D0HCYfUhb64ubdIGPahuIaiam/I5ngzm2F2ZrrtRcLy0IBaOdKKr27jCu16N+2oTyEAzNZMnhLyPNHw9BjN6oM/mxCGf5YIyZlykMdu9JYw492PCVORs8U0CjIhOBGfZFZ+Yajuwh14VDBpl+zfGrsUZy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXPefhTH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso1254506a91.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927537; x=1737532337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHHcojRyfX8w0d2GarvDuvokgmXzp4cSx9BRiUkHQ0Y=;
        b=ZXPefhTHW2nUGxrDaieQ3l16AfVYIgVejeLMMDkr4vHDb/S4epK8lt3wO7onHrDWxj
         0Gylv9wmQdePwLDKN6gOWveRg6GRjkRucn37GOtti/OjjCKMl4eT24s4UsPd8MX1FruC
         uAxTT/kkyaiQmIVVxVSYxygbdn2uKaJ5V/kqTiD60lzZa1ORhLi3EPIJC0+rm2BQJS0V
         fCZlH12qeeVZ1irNYxknz3PPwGQbXC96bwsIVWHjfd4pTO7/PJcetCtXbsaFe3an7s/I
         wLFq5R9Y+hvV4qspjI+rzTC1kmonWoPTAYRWHW9tuYlHAsrSJ7sFY7UbugPhnCkseE4P
         G5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927537; x=1737532337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHHcojRyfX8w0d2GarvDuvokgmXzp4cSx9BRiUkHQ0Y=;
        b=WRX63y4eJXbQTb2tgspUSnMS03omnv5gLfIK8PGZYHqAY3u7Xwpf6G79ZwPKgBAbOR
         Lqh/uEX8w/SHemikHnUm8A4YwvoOvdzFaglR5HTzHV87lGD6UXhI7vqHp+E1/LuIiYAH
         BLpOGg1ZUFLl2CwlriTGfP40DuLzpWkfw12Pp5v3qxffnDw+C8ooK4wDz/T2HnbE7z+m
         JTsehL648TkPKEJbN7N4UTLHJP1oJK0tzv5FgpTUN7rXIf06TUeTRigz/N+DvyqYxe+U
         6RYJIniU+lhICi3ux2jRF4WRxvN1KelldQf442KMKdfziWvSMIIajaA7/QkbX+DWnfYg
         Dq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/ro5dXVANkzd0wjjBzVUhxfsjcxSMHbCT75yuYpUOLtBsfByN6TT2v8eWrHakoioH6fnG8sKq0RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQW9l4NmTnB06mcv6DRahMqM4xsL+2zSFTZfYQQu6Ztw7AHVvb
	Lzu7ET05twp3piTWabONB+4hcZdjUBHPNMAgnoeNOyJ91ah7x8iVNZD+1euPPa7vRPSMSfOYtjB
	Kjg==
X-Google-Smtp-Source: AGHT+IGRQlcTybMOaaXZSYDveBlnwrJitcPE5/nY5WFVW4G04OpcFkhTLtM2qgYcsuigeMS6o2XGH7xsHPg=
X-Received: from pjbsj7.prod.google.com ([2002:a17:90b:2d87:b0:2da:ac73:93e0])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:2f2:a974:1e45
 with SMTP id 98e67ed59e1d1-2f728e36688mr3051220a91.16.1736927536997; Tue, 14
 Jan 2025 23:52:16 -0800 (PST)
Date: Tue, 14 Jan 2025 23:52:14 -0800
In-Reply-To: <68ef082c855b4e1d094dcfc9a861f43488b64922.1736341506.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <68ef082c855b4e1d094dcfc9a861f43488b64922.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115075214.3517616-1-pandoh@google.com>
Subject: [PATCH RESEND 2/4] PCI/AER: Add Correctable Errors rate limiting
From: Jon Pan-Doh <pandoh@google.com>
To: karolina.stolarek@oracle.com
Cc: ben.fuller@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 13:55:32 +0000
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
> Add a ratelimit_state to control the number of printed Correctable
> Errors per Root Port and check it each time a Correctable Error is
> to be reported.

I think the ratelimits should be consistent (i.e. per-device) whether from
GHES/CXL (pci_print_aer()) or native AER (aer_print_error).

If there are two devices under a root port and one is spamming correctable
errors, I think we'd still want to get correctable errors from the non-spammy
device.

