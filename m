Return-Path: <linux-pci+bounces-4261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629886CC14
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 15:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C9D285A9E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7412F580;
	Thu, 29 Feb 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="sEK2v9/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9517D419
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218364; cv=none; b=t7qlWQ2jiwKbSywT9EftaXlVf6IuhCHSm3ucH8mgn1bM8NuysedoYqYMaFlDX+ujEK42HQwvsc6kLiWkvO1lVFz51VfBfvdqp2ebDJFfr6gT3uj+3v036FWlzzZIDyA6rqsnSgKoBZiRe8RDAlKna8AxJ0m+eEAh2NscO8+rfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218364; c=relaxed/simple;
	bh=ZeGVF4pZyv+qY3kLWiHh74TeDF0rICRbIzZ06nyePhU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FWd7uKgRfVHln1Ia/USkGNaZVuVwReaS443qkyGcITsg4O+7UoUG6AqZvPUcAnb6DcK96VMcqxf5qhE0On/t1QeY3ht9v+SZp+kZ2cRvCVWyWtR4VjxJGqbdoIgDDGZE3uUMHhmnA3El7EPJk9JYbbbg36tvh0I4gzmOgntJ58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=sEK2v9/s; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=ZeGVF4pZyv+q
	Y3kLWiHh74TeDF0rICRbIzZ06nyePhU=; h=subject:from:to:date;
	d=aixigo.com; b=sEK2v9/skjHwqLplCw51QpvVBd/N/xyd29iHjTwAFUpBEM7cHn7dAH
	uuRuKu/UpntPR5EDiJPQwBHVNiGqRXhr/GQxRxN8dcZMZRom2Pwf2V8hnNPp9pcPxD8iPV
	Y/cQsCElS0sPPF99yv5YbrPAS6uKdIYi3ZdtvVxHAyU//wI=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 5737ea2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-pci@vger.kernel.org>;
	Thu, 29 Feb 2024 15:52:37 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 41TEqatC133924
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 15:52:36 +0100
Message-ID: <67576689-23ff-4e32-a93c-5bebbfc647b6@aixigo.com>
Date: Thu, 29 Feb 2024 15:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: linux-pci@vger.kernel.org
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
Subject: AER: Corrected error message received from 0000:00:06.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

dmesg shows these messages I am unfamiliar with:

[Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
[Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
[Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
[Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
[Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
[Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
[Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
[Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
[Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
[Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
[Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
[Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)

Is this something to worry about?

Regards
Harri

