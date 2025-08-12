Return-Path: <linux-pci+bounces-33814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F8B21BA8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C44E1902F39
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549D1EE7C6;
	Tue, 12 Aug 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yntf1LEc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8F1AF0AF
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969458; cv=none; b=GQeUmglFhTW9tb9nQsXpU0ZCjg+DJuffp2AWGgTDGh8s3poO6x1R46yPob5JOm+Fh4V0tcbQYiHWMt+JQB2IAEewek8BUNWk5D5ONRM2xcnwYH4HsblCNATls2OvtWptDTQik9d1D0EnYfsmyui/J9P/CFdC62ltGc5jXnwG9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969458; c=relaxed/simple;
	bh=4A5GvYmCMYexOZkBKI2kDUpNI/x2h7DTH+2Psyf/9ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isYmwzGe0hS1cGos7Sw4gk0kvccZ6GFTGqq7/Kj9R0XfgUd0OwCtImPGRCvfqZWZmkt9KCp2/1p/ldBDFbqiQIB+Izv9zWwUchtxKETDOpW46GSLwGUP2ldHCBJJnwoSOPMmH2N4tt4z5AU5QqbBd6QWcAlIPdMrSHF+SohpqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yntf1LEc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754969454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCkvxp64xxUOSuPCfrC7oiW0+5JFJ8BJc57BUtN/nPg=;
	b=Yntf1LEcgIK+pPuWQmuihuwSsj/FfKcXoF6HaCKoG9P6hC8xcvF5CacdyzQHNeV3Fpa9Pc
	iTW7mGjVceIuKJQAtaw64L0xwTBcjxeOvzrdCZQ/yxuNXcHkV5Y4BlInwAloTCL10N2J/y
	AKBPF6pgFkLynTxy5eXvCeChK8xuoxo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Xyz_b2cSOUeXnU5DmSCi3g-1; Mon, 11 Aug 2025 23:30:53 -0400
X-MC-Unique: Xyz_b2cSOUeXnU5DmSCi3g-1
X-Mimecast-MFC-AGG-ID: Xyz_b2cSOUeXnU5DmSCi3g_1754969452
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe26e5a33so76202985ad.3
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 20:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754969452; x=1755574252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCkvxp64xxUOSuPCfrC7oiW0+5JFJ8BJc57BUtN/nPg=;
        b=JG3viqIv1F0yio7xpy3YSbcCRbwoyiAp60yCKCVriVM4k2hqOaSfEa3OZYGjBYGMkU
         gJUpDnauZ/U1Li49JXGng14OWOOK0EJDxN/uG+cTf1KTrlH+HEm3d3U5tHgsAJnpxj6O
         a6TTolAJdJbH0OS5M8CVC2qhIkKYlGM6rbYfx+WFVh5qH1MUE2lItL9RWOw6wrc04cUR
         P1HfrZX8V+vSlUm2P6thQM2yTnae1fwx2bY0mBE8w6IWrg7y2hJvznyr+NJG+vikHKbW
         Ku66HAnKUfWgWb1sgNWIychSff4pawkX1HU29D/EMUGst87OR4BRBAuMR6IY5E7nN6GI
         tvAw==
X-Forwarded-Encrypted: i=1; AJvYcCX8KrUcRy5weHdPZmn1CWd45GjP0rNuEnb71qACeZlhyPeYCqNMe2TRLFTT8VqIep+m1AQ4Npax+eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf5RAKSSQ++bSdWkDi2vGE1OHhuQ/jO4uScqx2ApBDJBx+fMR
	VzCCXlQxYb7OLOEAEmC4QQEP42T/1cwCYTUJyfruTlZt1r4vFXq1I1dAmxNdLsB3Zj6+yxG68gL
	SxmCK5BCKk9RJGxjwPcPhIqgYnnYRqG6UQEOT4FRoUZ+xRmqDTCHfFj4+HA+qNj4U3YVO2dofkx
	E=
X-Gm-Gg: ASbGncvhMvM7c8pjMcChS4q65Ie8OV34t3dulv+LL+R5EjrVO2Cps59hGiFCt0lx1u8
	71I/pLnBqyQl+iN1OrwZrQ/Ur1B26JikbFh9862SCYGi4pULi73snau8f8juh/0XKPMKf8q4fmY
	30hSucIn8mQyPwNG2L979pUCZn9/U6uD/BNK0yGaeE+4EB15xm7mCDV+be9BzsniuDxEh7mnQSh
	J2W9iE3v3WR4Ygiea4kXqT1VjJq1HIunGeyIeMLJWoiE77TiOwS7gADuvEg+yfiLpiBlT9hHtjQ
	PGvt5EbiiH3YVDV8mDf19CjML6+3trc=
X-Received: by 2002:a17:902:f70f:b0:240:640a:b2e4 with SMTP id d9443c01a7336-242fc3683a8mr27219705ad.49.1754969451818;
        Mon, 11 Aug 2025 20:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsNcl0XLPCCner9/NUZ+yEfhqQUGBX8BpPGrFeFAmrdynsST1rXFBZLTyWU5C4N4/jD4ci1Q==
X-Received: by 2002:a17:902:f70f:b0:240:640a:b2e4 with SMTP id d9443c01a7336-242fc3683a8mr27219305ad.49.1754969451410;
        Mon, 11 Aug 2025 20:30:51 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm16030963a91.34.2025.08.11.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:30:51 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:29:54 +0800
From: Coiby Xu <coxu@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <ovyxlf7aw4y4bsxlkvjaxd5zs7jw5rnta3gyfmroazesm4m7mi@ebgu3frfd2bb>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87bjom8106.ffs@tglx>

On Mon, Aug 11, 2025 at 03:02:33PM +0200, Thomas Gleixner wrote:
>On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> Recently I met an issue that on certain virtual machines, the kdump
>> kernel fails to get DHCP IP address most of times starting from
>> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>>
>>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>>      # Provide MSI parent infrastructure
>>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>>      # Prepare for PCI MSI/MSIX
>>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>
>There were follow up fixes on this, so isolating this one is not really
>conclusive.
>
>Is the problem still there on v6.16 and v6.17-rc1?

Thanks for the reply! Yes, I can confirm it still happens to
6.16.0-200.fc42.aarch64 and 6.17.0-0.rc1.17.fc43.aarch64.

>
>Thanks,
>
>        tglx
>

-- 
Best regards,
Coiby


