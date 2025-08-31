Return-Path: <linux-pci+bounces-35191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A8B3D242
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B44189E675
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349D2512E6;
	Sun, 31 Aug 2025 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lngdPUcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420F24DD15
	for <linux-pci@vger.kernel.org>; Sun, 31 Aug 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637506; cv=none; b=hXhDlkSkwKgVleUTZIu1AARPxL4vWKxVaUq4PujC8vPyEw1KZON2E8sFW3M6FB+jqeokw/N2DGm8wqFsm7wfgsx7Ufm9cFn3Dpluhb6wEMBtudbWmiZuWmzurA4dicLBvFhP6J897A5xoO6Ytpw9954HKYf2ehghQ4WOJDbMP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637506; c=relaxed/simple;
	bh=5TQBlMcKz99l61oDupwcQxaI/ZfZHvjKjIfnG5PuYb0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VHpfRpC2HtNfXYYtqTkBBf0uoijKFAvPX21KUe4T9TCqbYlesCm0p7qhLT70fNNFxS9zjeKNZ0RU33w/xB/tLx7zo8j6Kc70E/NgF6zGeSXQzU5KQuAdN+sgNL82iv7kLHZJn14R7aRtG/tJUtkuhNkFFwH2G7wiX11/Ud7a9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lngdPUcw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-327d8df861dso1481797a91.2
        for <linux-pci@vger.kernel.org>; Sun, 31 Aug 2025 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756637504; x=1757242304; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5TQBlMcKz99l61oDupwcQxaI/ZfZHvjKjIfnG5PuYb0=;
        b=lngdPUcwJ9JqXEKmO4gI9PvC3T31n2DtIAetnrcVtHDKdvw5V+tSI9ey++H8uZlp1J
         1zqOpquw2/wW5FQi97A9/NEgbT8Ss3U4gtN3JSpZCyswS4mFKEiDLs4+qE1CXkR0Zolq
         1Lb+U1EFnd6FThxNz+f3a9beggAEN+6+4zMitt8c2D0+pobLtBTtqjPup6P7lraUoJ0r
         TPTjVWTNJV2MghDtA17LBMrsIKW1OPNC083+ia7pgebUQUNdWPBSxJgjPj+XIHPHyjrY
         1v04qdmHVd9JnA9KZjymV22mKPfHZh0Nom0UBHVC7NhwAKXJFxqElVLWrrnrU8ZEDSba
         7qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756637504; x=1757242304;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TQBlMcKz99l61oDupwcQxaI/ZfZHvjKjIfnG5PuYb0=;
        b=Lzhgsrj7OsoP6z8hHfq7IHil0+Hws2v0+Us6XVpdX+mVCNQqYWZWfJ7kbXXAoLmH5d
         /yIWzF7Pg/hFHW9NecTyuOPJ7KLG72PbjPD5+r7YfRbDRyDsmySZrMwNrhooTjFlojiE
         3XME+SVkO0IIm3tkgt7EsvhTd4rIRNDJb9sXWfncgf+FCTs9IJNGhuBUwnGBzxxNEvPq
         corrynCYzK6DdmUVuQ5iGflWjZyEdQYiPfHpogvt6HNAia7wV9MCbWfwFVW0+leQjH1V
         ++XQS8LQRJAGMeUmCdcXAjajXKNgM/NOS0ra6bm/l2xoqtpnZSVQBFNqR9HI/pNCYKsM
         95iA==
X-Gm-Message-State: AOJu0YzDNh1JLJA+KZpVWjlZoxjg34kM/KV46ELSyLIfni2g07VsWxU3
	hTlSEPFGQsQYbSs3wZJ5De9kqGeJgFwinnx2JXnapxFT2+/v/5a9tIbuud8/lIWl+9ToB2MbJeO
	E1tJ9nM3rRaISfkYhmpWkHz7Qi37Mj3jmsV+c
X-Gm-Gg: ASbGncsgedj8J0i/pxatV4i60aB9J0hW8NZxWFPqymhIy0s5jSh39rgDLrP8RDWyROD
	v9pvjUFN2FmXFl2FtaSmRC/LUTJHyMD0vou7xfRwgnJ4+tw6s8S0ic7jeq1Nn16pQu3BFA1NF2k
	OGCR207DwdxbQKXLon8Kzo59YApTyeyYSBGdqIR4e0S8rliS8ytGnKx3kvtUpSnMFbbA0s+pEU3
	/37Bw==
X-Google-Smtp-Source: AGHT+IFyJAOz6s1+nD+y8bAcFUirAGrDKgMy1sEwpQV7K2TV0Tvb+K/cnHqWBwgY+1q4I63gYS1YjnFQ6kYYVM+aQv0=
X-Received: by 2002:a17:90b:3ec8:b0:327:9735:542b with SMTP id
 98e67ed59e1d1-328156e57b1mr7125173a91.35.1756637503963; Sun, 31 Aug 2025
 03:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Oswald <stevepeter.oswald@gmail.com>
Date: Sun, 31 Aug 2025 13:51:32 +0300
X-Gm-Features: Ac12FXxQaf3i69zPWBaCq1KyIcdQrr3jTXxtLIaJp-Pebx3ZDNn20qf2W7S8his
Message-ID: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
Subject: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to assign memory
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99ve encountered an issue with Thunderbolt eGPU (externally connect=
ed
gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 broke
the pci memory assignment of the external pcie device. I figured out
which version broke it by using ubuntu 25.04 and downgrading the
kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/=
master/ubuntu-mainline-kernel.sh).

From the dmesg output, on the broken 6.11.0 I see 'failed to assign'.
The issue occurs (almost never) on previous kernel version 6.10.14.
Using pci=3Drealloc did not change the behavior (I can produce the dmesg
output if necessary).

The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVIDIA
3080 10GB). Both the amd and the nvidia driver fail to initialize the
device because they cannot write the pcie messages.

System details:
- Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-061100
- Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
- eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB

Steps to reproduce:
1. Boot the system with the eGPU.
2. Observe PCI BAR message in `dmesg`.

Logs:
both kernel messages, lspci can be found here:
https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
raw files:
- dmesg_linux_6.11.0.log
https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af=
/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.log
- dmesg_linux_6.10.14.log
https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af=
/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14.log

If additional info is needed, I'm happy to help.


Cheers,

Steve

