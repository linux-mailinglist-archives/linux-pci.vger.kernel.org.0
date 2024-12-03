Return-Path: <linux-pci+bounces-17614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F019E2FDC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 00:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87716283386
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31001EF0B6;
	Tue,  3 Dec 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+GuzvKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA3762EB
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268652; cv=none; b=EvPt5jLAFcm/zuRlDL0L2ODlo/Tftl6+csIF9jaPAvEOB96HiSQDnksw/6ux/nIJZwLR4i70MfSJILDYlr8zhLDBSQBvjkv28JTvHF8uVEscLI70eqEiimqUNljtx84uweeHvcDZi88czoQl/8JyG7ZR89zBAzUNFEdxFk6RTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268652; c=relaxed/simple;
	bh=PDknFXdpGhwUK2oPlbIEPPI4qbuJekgaWv5QKIrdr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM+Te8bBgxPZVkIgC21WK1RJ1H+osRRBt3DJcrNGUWPpq5/+iHlXVkxGzwVvL+ljurVWkfWWhy9b539bKqVh1envPNX40fahfCDSymT2qob39tZF/Ezz4i7jswFtMi9AEvPkKyGDNoGB1jpwucA9VhtOyf2It48JEjEqHIa/BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+GuzvKq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733268649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAco2OnlW8aDB56vFSNzE6OdCv1iUGJFAjN9JJ7q2Z4=;
	b=U+GuzvKq78jUP/8R2c5yYbHRIDPWUeCa6nSjMKlFgxkFPGEBAACL/ABqbDlrEdD1wEZkPG
	qAnnqVIByNL0e3Za9JtS6DBgPRErCIL4SPCxALJP1FL8SRwuAgLICJvDov1HPXjwspJtqG
	fClpGZ4cBV54/yDCd7my/84w1vYvMQc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-kr-jAnS7OfWvys1-5E2jEQ-1; Tue, 03 Dec 2024 18:30:48 -0500
X-MC-Unique: kr-jAnS7OfWvys1-5E2jEQ-1
X-Mimecast-MFC-AGG-ID: kr-jAnS7OfWvys1-5E2jEQ
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-843ea388183so31822439f.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 15:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268648; x=1733873448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAco2OnlW8aDB56vFSNzE6OdCv1iUGJFAjN9JJ7q2Z4=;
        b=TSzdh9TGlpY+aKNtw49d1wVm106sIZiJoA19SPzWOp1ZTnJ4xqlcq1h7PY1RVRtSa4
         AAcipGgIpTQZ/vE4tNoAueHG4MCH/1aivom/Zf4kdyx32PjYWX0hR2Keeb1JaGeGIP2c
         0lbPQIWdz9tsd++twqwr+ooS/gPOe32o5xSh6P86V4kzFD0Kfh2qAmX+B5Gx8EQT4qg6
         VtPrHgWEMvWrGzVk5EauX1QbTaHRKRF382TRgDc5lSnNtpZXE3UaH4os13UmQiRjsCPn
         WeE2yMsuz3weh3fR6sw/5AStApcR8mOwVLZ93MVCOLcj66nwNXiXjtrGRbI7Sc/5GWir
         o8Tg==
X-Gm-Message-State: AOJu0YzZJYyyBx11cvwmFH2QpDXZB/daW4tuq4zp4Wep0Qc9PGr2dCBC
	V8GbrPEGBkMQ7hEBKAzB6V+nx44ybxWMcFCgz0b9tDGOSl3EUGZcn2nVoDiLaX7U2gikDkJq4OA
	/YzzaE0RUiKPm4OjnbDl/Tc6IzrSC8oOsj57dpyAsLRirsuOPkgfgFu5AQA==
X-Gm-Gg: ASbGncuh8t430/TJlkAILaIkzl4uVKsuPxJX3W5xBpgipDeJ8NBpZqZrwyKBqTKOmvS
	sg5BhaIToIB0anUkeOwVaHsczBTznguxtq5GWSbGqE2+PfWxTn9SDTu6yyr4Hqd9f3diLeYh8MG
	Eu/DkQ7KEsv2G8/Z77fFv1xsoJuNMFs71l1oSCIZkBKlJJLtjVlF8KleQZ8VOd4QabxymAcDHzF
	6WbznBX30hamIeHc78EF8UjGZ58YvUtnoxRTCVvR6/iOhs/RHow7w==
X-Received: by 2002:a05:6e02:144c:b0:3a7:bfc6:99 with SMTP id e9e14a558f8ab-3a7f9aafd7cmr13695685ab.5.1733268648074;
        Tue, 03 Dec 2024 15:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+wpy2rKtQZFbUAdq3aq94BSEljgs8jDST4Q9+2gSut9sQitp+ZDXPOMOy+3t/TK/Xwp0r5g==
X-Received: by 2002:a05:6e02:144c:b0:3a7:bfc6:99 with SMTP id e9e14a558f8ab-3a7f9aafd7cmr13695605ab.5.1733268647775;
        Tue, 03 Dec 2024 15:30:47 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc5ff8bsm28460895ab.53.2024.12.03.15.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:30:47 -0800 (PST)
Date: Tue, 3 Dec 2024 16:30:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241203163045.3e068562.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
	<20241126170214.5717003f.alex.williamson@redhat.com>
	<CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
	<20241127102243.57cddb78.alex.williamson@redhat.com>
	<CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
	<20241203122023.21171712.alex.williamson@redhat.com>
	<CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
	<20241203150620.15431c5c.alex.williamson@redhat.com>
	<CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 17:09:07 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> Thanks for the suggestions!
> 
> > The calling convention of __pci_read_base() is already changing if we're having the caller disable decoding  
> 
> The way I implemented that in my initial patch draft[0] still allows
> for __pci_read_base() to be called independently, as it was
> originally, since (as far as I understand) the encode disable/enable
> is just a mask - so I didn't need to remove the disable/enable inside
> __pci_read_base(), and instead just added an extra one in
> pci_read_bases(), turning the __pci_read_base() disable/enable into a
> no-op when called from pci_read_bases(). In any case...
> 
> > I think maybe another alternative that doesn't hold off the console would be to split the BAR sizing and resource processing into separate steps.  
> 
> This seems like a potentially better option, so I'll dig into that approach.
> 
> 
> Providing some additional info you requested last week, just for more context:
> 
> > Do you have similar logs from that [hotplug] operation  
> 
> Attached [1] is the guest boot output (boot was quick, since no GPUs
> were attached at boot time)

I think what's happening here is that decode is already disabled on the
hot-added device (vs enabled by the VM firmware on cold-plug), so in
practice it's similar to your nested disable solution.  Thanks,

Alex


