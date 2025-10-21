Return-Path: <linux-pci+bounces-38866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17105BF5B87
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E214EB7C8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFD7DA66;
	Tue, 21 Oct 2025 10:13:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D189329C77
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041601; cv=none; b=ODdcbEkkvhWcJOcq8QahYnx2HycyzevtTjuxM4rLqmwpHMkG13FjSSl7YerI7sh4ySUyY7Su2n4NLiVptgdS7aoQq6lfuPZoaLwxHcdWfOJfodCi0nT7eARJlqWijl1FRRglJIcNzicPOjZcRSf/DtG5ozDmfwJeTSirtgeM5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041601; c=relaxed/simple;
	bh=Gtbs6umIS5Mqml8h+iLcMInjuHRb9lLp4feLN0poetA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VvnChatx//fribbkECOA33IfsaI+MPKJ501qBqrQhGtZ2w1gRhole/sxFwrEZ0QEgKicWrYmMDZJDZKFHZhm3VC+NbHWS4O0IW1QyoloOT3hjH8uW5PDGoKkH1EGqHFmfbMRGTPvuwbABmue8pKaKWA2RcaZncJG4KceDIJDzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1761041544t6e0ad998
X-QQ-Originating-IP: KZt8UQ/l993XH8HuRDNma5R0zqC8lmd7GcqPAWOGRYA=
Received: from [IPV6:240f:10b:7440:1:fbdd:6094 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 18:12:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5943898346792246940
Message-ID: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>
Date: Tue, 21 Oct 2025 19:12:21 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
Subject: ROCK 5B/5B+ RTL8852BE probe failure on v6.18-rc
To: linux-rockchip@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OOCyznbq6KdUOlhtP0nrbpkbV8twnXANHbpDcjuiTn6Ywx7yypNCAIGM
	mK26/ptNPW5SQSrDNC8WgqZFWvKIurIn+C0DdkmxCgmKegjU3dsy6pjSIFOj9BWUmPbyCl4
	ZU3EVnGnsjEAvT8WP44uZoftepHbrPBzSyC/RR8i1BbdB73NDCLX4WC46tqpVaBFsu0vzxi
	FJDOTBqB+m3avNDJUYUvI8Tv28R2LBFkDcpClfib1ku3qpiQeWy6dH+d0iWts/3IlDMesY+
	lmxH6tkn52bi4vWu1zAWLvaVjGM7J2VpcX+pQjOFsMhe4usdm5NNrkgwHjyOAze6hFI1AuB
	IMqpg1Btyqtw+LUBMIotR/1XcHVQsyOCKOC6VCcWn715Iu4FG0kQ9nc4nIktF9cMOzoae9j
	ff07JHQo6MLV55iXwca9pqu/I7vexMOyaDXcrbEeLc/JB7fbdNX8AmSvWyb1xVUi+TqgzHM
	7rEebrgZ4nmOznDXwT0ckTQ8UuC8KqhBh/VsKqF5gQ5LIas/E5dMWl7CegyJBk+MR+tHDzw
	Ycjb5RLIemtc6DqwZfbzdpqY1kvGZ7nEcELg8Fe/GfxbQaHZwM7AGqbTKTPSelV6EU3KGgs
	250UeqGJd+IxO6IENLz9U8wVAUalAkW04tuinRKEYFFnOtVJLtycxVJMXKeH96U5FE9LHDM
	eOVMAW1WnRkorpy24QCb0F0i3DJtUyLkQLrR1ISBfaFPwpUR2RC8ei+RDOCWVHXJV7QcfGQ
	4Sp5/ou2mAOHeXGGCMjS/I5R7fMViu1MZv3aTBkeJ3Bp2PJOOMfpn3QBx9UwnO0poFuW1Kb
	vxuM2ojLNRJqQcOdh5EHJFHXMOBAZB2CDVPw9I9UpU2N9ApLc1ZlnwJinl0wliV0zYVqJOf
	5/G9pShitdt8yQXllZyW3szLY1MgzeiIA6dqgcKG8Q3+PJOjSzEXUhAdeif8Wu7Nfq1RWlD
	0/6f0ewsmdvubbUpiGg/EDqHKVfVEfvF/2fbwyyWXHfwPFcdVFFHJVxivgIhPqiYTiu9jo/
	uMvT83Eg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi,

I've observed an issue where the RTL8852BE fails to probe on the ROCK 5B 
and ROCK 5B+ using Linux v6.18-rc.

[    7.719288] rtw89_8852be 0002:21:00.0: loaded firmware 
rtw89/rtw8852b_fw-1.bin
[    7.720192] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
[    7.728596] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5 
(da87cccd), cmd version 0, type 5
[    7.729407] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5 
(da87cccd), cmd version 0, type 3
[   11.420623] rtw89_8852be 0002:21:00.0: failed to dump efuse physical map
[   11.422859] rtw89_8852be 0002:21:00.0: failed to setup chip information
[   11.425273] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be 
failed with error -16

This issue does not reproduce on v6.16. The issue does not reproduce 
with the MT7921E or the AX210. Furthermore, the issue does not reproduce 
on the ROCK 5A or the ROCK 5 ITX+.

The issue appears not to reproduce in or prior to commit 14bed9bc81ba. 
The issue reproduces, albeit with a low incidence rate, after commit 
bf76f23aa1c1. It reproduces, but not 100%, on v6.17, and is likely 100% 
reproducible on v6.18-rc.

The dmesg output and the result of lspci -vv when the issue occurs can 
be found below:
  https://gist.github.com/RadxaNaoki/bf57b6d3d88c1e4310a23247e7bac9de

What should I investigate next?

-- 
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

