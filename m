Return-Path: <linux-pci+bounces-33686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C51B1FE14
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C195B3A2A5D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 03:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A81991DD;
	Mon, 11 Aug 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmWrLSLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813D12B93
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754882756; cv=none; b=t/tVEDH7PThH48/hWv1cE5V8NjFtHvALlS+BVVqvE5jmgmGtBevxZX/8Ii8Fvy4Qu7RKqqLParNNWEhilXjyi5LqjtombV67E1gndPgS0Ni5PB5Pf4zIdsOWzxcaLMLNaZkYvLWurdA1ZRpB703bPVXoewUR4hOXlUzEsI9ks10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754882756; c=relaxed/simple;
	bh=p8v3CGh3AqDE9sU6mO3MmhmT8UJdaztvV1UQb77S2fI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GYa05174kmWAVr33sQnc9Pozdnsd5+oHJ3LJgZU/pxeZ4YNGqtOlWoYNRpnwyw7HfAIsXDwzcSMZTO8lhC1LphpYBcxO6tiuQ+0v8ggGc99WEJqRpibD6JqisMZhZvl0EcwI2zM1mTrQ3PAq/WarhMaQ1PseyYca9/ENzK0INck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmWrLSLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754882753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MyI6bQ4VKi6kzEU6MGPeSA2rT56TE5vaJOVAfdMj034=;
	b=KmWrLSLwaomaSekNGut4Lrj6OoXDGy+xWNPSFJymkxNF4KJ1U5AyaohgCVCVOKIQY9xd5C
	6f9jsr7WM0dxLpAEt5lI9+XC35ds7jAaCuWzyHUp4vHH3gcv2BJwIazW6KZ+Pcf3PHs+vR
	jgdDiTieMH7lZuCTBUHtlRwlLa9tFvo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-J3SFDRXyPuewQI6hUdXSPg-1; Sun, 10 Aug 2025 23:25:52 -0400
X-MC-Unique: J3SFDRXyPuewQI6hUdXSPg-1
X-Mimecast-MFC-AGG-ID: J3SFDRXyPuewQI6hUdXSPg_1754882751
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-242aa2e4887so90160705ad.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Aug 2025 20:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754882751; x=1755487551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyI6bQ4VKi6kzEU6MGPeSA2rT56TE5vaJOVAfdMj034=;
        b=HeDRuQUzYv8wirc66yuuR+mQsCG2iu+WA8Qs/LPouQ9M0/p/5vATrkE3fLfSHVB8oi
         QaEWBC8yPqqDJod5IdNVLJtJMmXwXWEWBh3DPJHME/m+Rk9X57ejGxXSHgevguZNehe/
         ceSFVtQX2yL4OYkQofvePUDlahrixQj3xsWx7wLWHeaqHXVIUDcL78KfSw7DtsSmlZkQ
         FuWFKyhNTLWT8d97Z166h+SPQMGcsS7/+DA7aRQJNZRsl6Ey5HmhK8umTn1BTnECVitD
         BxqnoloR7FhaKgoRx8bHLXD3FUI2HmnWpP1BEG5Ky8OAeuyXuudj0T9ORCqIumB6770s
         sqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4HbnTPvYMhqvq2ORTK64Ijb5L2P+U+bpcGrJjhAof6ms3ICCfnoy/ZiXe3ziB/da17Q8YgfGB2dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqiy9pik39AKoGLH9vTr8kVgDKiKRHJxx3g1rGE9NnL6PF0Tee
	9+k03kfYWurmwWqfZQX0CKz1UOYTh/j1Nx4WHU6jJbs9tNVw2fXFCyQULZ0RPpUqrrs5TKa3KGM
	MfTas9q6GwPN6GVA8psa4/NxW34ahBJIbxcbHwKhVCliwXjyEfzBRP0BU42iNgadSFQadJICuOM
	U=
X-Gm-Gg: ASbGncvG9edjHzOcpPCrfhu9PCjvytArV3XIE+RpoFloF9iy9XYo0hY7UeQfAPHTQoV
	UplY+9a39ThPLnweqreZ9RDrnkAMGumIzmDWsV1t+ND0oGWbWBfGPuybh0c72Q1PxIcg3OMaQTg
	TfoGHQC6XTjBFDQAc9Mgfo9gqh9f46I2ch3giiyto47j72mgqt1EGDNVzN9ZUx5xw6jkP3d+Qt3
	nSjmXPHjiiP3vC/BpoZyNYJJpL0TPyLvsgeABlEMeT4E8Ulhg05YFGDrF4hxY3qzj6y3xMO5qPY
	n/gwwtjkSifSnEinLr8IAB+FzVyCv3I=
X-Received: by 2002:a17:902:f641:b0:240:7c39:9e25 with SMTP id d9443c01a7336-242c220019amr145851305ad.27.1754882750969;
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGij+iLLH1kTC74+yPsc/frGl3BwTOOImoH7zdGTiZxVFriyBsG7HIux9tyLkoa+5Pjls7KUw==
X-Received: by 2002:a17:902:f641:b0:240:7c39:9e25 with SMTP id d9443c01a7336-242c220019amr145851095ad.27.1754882750559;
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6a8fsm258509715ad.23.2025.08.10.20.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 20:25:50 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:23:49 +0800
From: Coiby Xu <coxu@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Thomas,

Recently I met an issue that on certain virtual machines, the kdump
kernel fails to get DHCP IP address most of times starting from
6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,

     # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
     # MSI_FLAG_PCI_MSI_MASK_PARENT
     git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
     # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
     # Provide MSI parent infrastructure
     git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
     # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
     # Prepare for PCI MSI/MSIX
     git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
     # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
     # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]


I'll appreciate it you can provide any suggestion on fixing this issue.
And I'd be glad to verify any idea as this issue can seem to be reliably
reproduced only on certain machines.

The aarch64 kdump kernel on Fedora is booted wit "irqpoll nr_cpus=1
reset_devices cgroup_disable=memory udev.children-max=2 panic=10
swiotlb=noforce novmcoredd cma=0 hugetlb_cma=0". Removing "nr_cpus=1" or
"adding pci=nomsi" can make this issue disappear. 

Note I've also reported this issue to
https://bugzilla.kernel.org/show_bug.cgi?id=220328

-- 
Best regards,
Coiby


