Return-Path: <linux-pci+bounces-24986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29629A75A6D
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DE7A32FD
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E431C3F02;
	Sun, 30 Mar 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="gGBtNgWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C41EA65;
	Sun, 30 Mar 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346656; cv=none; b=ZXYCv3E7dYeRPmI/FPsLyGxiryorR4qSAPeoefqyG/II4A1ZlCxofxrDdoTSp7MGqNjdlI1P6aYDy9aQfOYqvpm42n24kB8H/kHX4U8p3xlHOtL3bKtVxXEOpoh4EuCJBerOH5hPm8bXYqLGTvT29bvpBuNMh2Uavn4C5LN9JX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346656; c=relaxed/simple;
	bh=paMlcnbsyzixmxEKIk7TpgKIis192RtNpMFqbarKJOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hul3eHLDtYxJ3tSHD5KDGuZiUjH1t/GpQZ9mR6fIKQKpgkUetCXr3SoAiMxOX7W/G+k0HiVIppAC6fCaC8rR540RT73eiGg8dZt5rSgo+5PZT9FT00at6ACvoXzi8c9KM6RZDDo8xDrvuM/jsXDrTeE/iemYFh3Oe0N8286p/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=gGBtNgWa; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743346644; x=1743951444; i=spasswolf@web.de;
	bh=paMlcnbsyzixmxEKIk7TpgKIis192RtNpMFqbarKJOc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gGBtNgWaQigjbDZdbhArPRoyl5PvwqghMU8VVCNUeJuS2XrHDtSiJjxotPUqv1O2
	 N1RMN8z4AkSOsiLDjo8QKOUi4YzC+NyshnXXijTRUR2ywlsUqH2klnH1MEbToBjyf
	 mb8Gdz8ZMvbePJ2sxQ+JcZQ1Ig5RKuaKIGLKoWvQv0dmgTW7Zzc1eUHiWotViv1x7
	 zgqdNA7Ro9EtkRfKsQ3n0pNsoUB2X1RbzpDQ3rShB9XSISBrDk3SBCjccOpRHPAfE
	 QD6FATmLTqx7Z3R/QdQcpFQX7PhDp4D3SxkiibgrcNQdiOdr7vCPS0lUUQ4IYpZqy
	 +LMVjhFTRqv7dpxCJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mxpmc-1tC08g1IJ4-00wRcp; Sun, 30 Mar 2025 16:57:24 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	"Daniel Gomez" <da.gomez@kernel.org>,
	=?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
	"Bjorn Helgaas" <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends
Date: Sun, 30 Mar 2025 16:57:17 +0200
Message-ID: <20250330145719.32280-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <87v7rxzct0.ffs@tglx>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nkWDZ3wl89O1RHvPpDsRC7wrZxkyQ6Ar8ilNgBDFHoUFD2MBzVs
 1nPuJFIQE+DweCB5he01EvPkRIoBrglw4JAuqeK+j/W3pVnn5GXnHymx9dKP7Kw9mEj/IKc
 53NhvcKE0M70gKCVKzI0DHtN/RCBJ4CU/a3pFI+KKhabc6ZujcgQsaD8saibq531fJb313o
 ngyCJ1po4towA43WKAxjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wJCifl4CpFM=;pIs1w/sJ/84spZPO2nx3agN2Pnx
 Ae8afovBO+2C+P4j7qkZ9pgPzgAhOgIxrjQTbSs3FvZvqSMxOFa1GjqdsCGhHLmS+rGwJp0OU
 MUTOCOjyvLotFw5PIxK7yPe3oFmXj+FpeipFrzGVqKkW5rGMKXELshSiQo+roGQQA1/BJV5K3
 BskBSxNgb1X/Eme532dvlvgGny2myzvVXnbrcxFO84DUwgAJIP2qL4S1E9zvMJ4MKSI0WwJ6a
 eMpS5tvDgmHoftVHgAimZHaAbImiD9HIK6mXUGtRm5NNnADE3fIu9YMV1Xyppg0Mt0EGk9aPb
 oFbS8zsafr92I5ut4O81OeNVfsperzs+vzixbHe1/QnC12JS8k/qGc8KZXQAwbpXvWK+RtzkK
 FxRqQWxdcZykhklJF4NdjYUJwH+EI3jGjKvieKnHRHzJGl07+wC3ynLm2MnMpCwl5CTGsrzmU
 1RjyQ+qV4MPzsJbeQAT5OWlQEJcqszewE4y3MRVz/FhkDTkig3cev3MYkoXctX+k35sgznXEi
 uMasZSj+hi1J1/y/r/r5g3R8EyMSvQFF6mxaBB1LLy9AA3Vc4tAG25Mwmv//ovNKYtI/9gUAg
 aS3GdPEOvTxGu08TsgCPIHzk9VMluzl1o4pdWU9IE9dY2304pxhjf6eb7OelxSU6UJyfwGpEu
 zJXhkMAoNirJnAVVGhRWQ9gtBzJQ/01g6I+du8mOa+IGBZeH+hLZcdLFDMWPThuSCSexSlbQC
 0QCCUGMe+X7OeOFavH2taPu7OI+O1CgtX2x6iee/okPXNNauQsEmxW/zXvJvMm0clnkJ/THlO
 vFSLygdTDRjEqpJE47mcZiEom36ssyoI3mi1yFXz7fIvW8hbAKexz/fkTR/rd8KRoadT+fhKv
 SnCdruPmrJa8PJ4RIyuxk8nlis8rfO0BV4is745M7yd4VRZ764VC3aLc+3QW38IVs25gqmPAU
 jLn/zGJjcu0ODi0+ju0O0s9LHoW3u3rtrJIZJYDt7ix85CFrE+lpdBjUxpRdolCisnwNj8qEU
 iSC3io79qQ8jnQ49NVnLRzLRTc/N8dWnkD8Y710xKpnV3Za1gCDzqmqMtNyed2shlFFaojvkb
 PEXcc2i6tRCqMMnmBYMDw9PzLd+ez0FDSRaaKuqLodZbkOUDvLY8fbNNBOowYRQzlVvW7Topc
 DgvlX4tX81mWj8B1ZmpDmiTcTRauPdMoPqNjJgPqGo4OeF5DxAGXLGPalRnTXBRyr47x1dCax
 bg957YOIqkN0Xc7Zb9bBVJQ0VEvn5vwmPvGleEyEa2w17kfPUWMdQUw0Yh5JxDP6zvDFysY7t
 xPiptEL4ng68xMP1yLr6xBt25fcTB14AzMe35aA8ia8ReZvclaX1b2/CMx/e9ZisNK0RWlza9
 mTP5V/4/ao+gUm1gK1EaUsDs1NhsAadeIkSzkNrh5Amqs17DD+Q+3Bu0VsX40dTs5tddg1c3/
 RhqF70w==

This also fixes a timeout error in the nvme driver introduced by commit
c3164d2e0d1. In linux-next-2025032{5,6} booting hangs in about 50% of boot
attempts with the message:
nvme nvme1: I/O tag 4 (1004) QID 0 timeout, completion polled
nvme nvme0: I/O tag 20 (1014) QID 0 timeout, completion polled
after some more time I get a message about task udev-worker blocking for more
than 61 seconds and get dropped to an initramfs shell. I bisected this to
commit c3164d2e0d1. As this error does not occur in linux-next-20250328, I
searched for commits that might fix this error and indeed cherrypicking commit
dbc5d00074fd on top of linux-next-20250326 fixes the issue for me. No xen or
kvm was used in my case.

Bert Karwatzki

