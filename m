Return-Path: <linux-pci+bounces-42675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10846CA5FAE
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01163198ABA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E63019C0;
	Fri,  5 Dec 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Js9ZwfpP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD63019CD
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904236; cv=none; b=d9iJE3zvLGNk5e86vzXWjim7qSWxM9NxlmyvqmcUEdDsPYacKnVgYg//Ud+bVzIIe1ZDK7whhb67UhJXp1Zv+HyKeDWO+AIzmsI1sOzXEe+aggVov5i35h3uBWzRDtWkIeBJacUBJeTmRHuNs51j7+imQzaQqJmuYJOmQfIAccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904236; c=relaxed/simple;
	bh=ygspLW8P6JAe7Gb51HLLP/aXsA8s+yON1SUxOxhEStI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exevrxcvz0jFd4ys1CL9uYY33CVJsq2E5Na2Usq8nhOFSNeNwrdbe49n6tForb48O+REDuFVLzX0SdYqidZD2TgPtLX0RLdJV+Phv0jb7Ry/+Cgglfxw9XeAE+4D7g3pSIVY57X0CsfWtMI45qecIe42W9TZjahJ6z977IZCafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Js9ZwfpP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5365F40044
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764904226;
	bh=SoH1y0DSVy4YFKDSU0IT0GiihjJuPvFPScPftJZMvzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Js9ZwfpPTQyRgoM+BKNXxfdWP+t0FP5Umz9v8MBOfI/UkPefZLDzURH3yoYfciz9Q
	 iiZPmfxYcmHZGGoThEL6GycdS1tyj6aG315y9yyu7TtCxQF8IEHz4PcmKFRB0bOytJ
	 WeWApUZrH3LxmRfyq3/atLofcSrIGNxRKsw1qclW64mjlLZelsP72N3lL/5rxMdPW3
	 2hoRiEYtCU441Vv1pttjVVLmZIoQKQ3K5GsOrN1GJKWZImcqfYSBEZzI/4KdWqMCFj
	 ERuN/56i/hRH5AxUkmLKbPnAtuagXjm2r9mreykuvMNK1Bdupe6ZBL9S7ENX+uFyji
	 sPX6Npdk702U5rx0+6Rvwusb368AijtAVRkZI4KceTqxy8iIYJCPFBpe59jbzpUvWS
	 w7cXCKRpMWwCYU8Bf1nA8PjKC0wSZ9jWDRWhOoEL0A9WboFYiYYC1AH6e/777+ACD/
	 aifBXGrA7eBmQfuWycU1W+Dq/NptZjBtnod8+DDeVXhjIdhoC3VXrqp5UZSN9uStCL
	 KCiXTi2SF81sehRQNZWc6qsfEc0nO5j1R/Ier86JrrKk6ufRY7yEsNObkuP+lr2ofZ
	 u4/AWBGyZdAp4CbC++4cKjF7ZTsJiOuiLFQ+ADirrtMChS0vuZ7dYxRndsRV7NNB/V
	 ppxw0Zn8GZG/qDR2UKTcLK+k=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-786a0fe77d9so23460177b3.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 19:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764904225; x=1765509025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoH1y0DSVy4YFKDSU0IT0GiihjJuPvFPScPftJZMvzo=;
        b=MpyMmzIDNdUvSg98cO5wvHqUNvOqVLsgZTXIMWZdx7Q04YtbD3pMGTQnNn4AVutt84
         tXAChicoCIhFgjzLDiI9N9b7oXLtqpWwXXgBHUj6iuESOQRK8ev7X/+fh7zRpInxDWfw
         vL4RLA9tNvmi4W1j5cZhe6IK4MWKAJ7tCjLVmnyZ9CFZblCyMp0oIU3uprjYU20a1v47
         GbkW+qwDZ9oEiD4GqNivHn25oC6s9f+tWoLEBh4TIK6Arc6iJQw3ZQWkiAjKtdTCD7P3
         g2cgp0cvin0CH2MNsTDsa1J1FPcsGrYr7xogNkPvLrSPe96o0e2pbWP0AhQ/agQrT8ac
         wziw==
X-Forwarded-Encrypted: i=1; AJvYcCUqWIGv40R7hhiwDr5g6ccC6Q1GZlvuwXlRK85oXfkCAxQ4wGjnblkFpIhVH4TBv9V+6zyRcrzmV/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylaoz42IEz8glfZimWjMg3EWrQ6NREaDgAnz1KLPUoSQVH3mN1
	VRn6D70hBfQPvsP0j3+4ywPV/R4aDO0wIhrbMJg+3KUcYigXqPp/Ojvhah6k74DpZikkcO4gkEd
	GQt5Uip7ok8TzT9twKihlP3GtLc5ZRE/1nI9BXS3LlRtM7FWgTjeBk2jt8HoptamPoF6ZRBCibk
	HyeUBlakZ50EafEJDKdMzVFakrKZbtLqWnHtk3ip9sFpgP89yXi4Qw
X-Gm-Gg: ASbGncs3DzFzH8f55ZoMAfD0oharl+zSyqu8kNHfgh7ANc/atKvMe5TuvXFaZt8lZLh
	sMk/DOQNgCWRlRdeEc758jwMPN4mZEQnl6bDHGyfIE3j3dy+cYNM2rArMijkJIYBQnt+rCepLyv
	YBXxkcA7sjyBjlaxDc+rgM2qOmWatnVXMSWaelve4qgEHCbS2GtMFpG7vYTPWpYw6Bwg==
X-Received: by 2002:a05:690c:4881:b0:786:24c1:9d9f with SMTP id 00721157ae682-78c0c17d671mr73339907b3.54.1764904225418;
        Thu, 04 Dec 2025 19:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8zVYRVqOt45/7ZA4S/eKcjWW99KyaNBv2XpETVc6QfCZPPnEbUWhArsZsW66QQe1oQ/SL+FeUCyqnTGxlNmQ=
X-Received: by 2002:a05:690c:4881:b0:786:24c1:9d9f with SMTP id
 00721157ae682-78c0c17d671mr73339817b3.54.1764904225142; Thu, 04 Dec 2025
 19:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com> <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com> <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
In-Reply-To: <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Fri, 5 Dec 2025 16:10:14 +1300
X-Gm-Features: AWmQ_blctGvnKj2BCVI2qqBTtf6I3gRyHGsDlKdxRTu7YiRdJVI0AgSVa8ejmkw
Message-ID: <CAKAwkKvoRW9QE5tt+B59sYYpW5DcGP6f_+0nObzVhw15-KhbNw@mail.gmail.com>
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Sorry accidentally sent the message.

The nvme was still in state 0 / PCI_D0:

[  109.801025] mruffell: vendor: 1d0f, device: 61, state: 0
[  109.819542] nvme 0000:90:00.0: mruffell: Current PCI device.

/sys/bus/pci/devices$ ll
lrwxrwxrwx 1 root root 0 Dec  4 23:24 0000:90:00.0@ ->
../../../devices/pci0000:7a/0000:7a:02.0/0000:8d:00.0/0000:8e:01.0/0000:90:00.0

All of these devices are also state 0. Interesting.

> > I have a relatively ignorant question.  Can you reproduce with kdump and
> > a crash too?
> >
> > I don't actually know if you configure kdump and then crash the kernel
> > (say magic sys-rq key), does pci_device_shutdown() get called in order
> > to do the kexec?  Or because the kernel is already in a crash state is
> > there just a jump into the crash kernel image location?
>

I did check this. I triggered a crash with magic sysrq, and
pci_device_shutdown()
was never called. It never printed out my debug messages from
pci_device_shutdown(), instead it just oopsed and booted straight to the crash
kernel.

Thanks,
Matthew

