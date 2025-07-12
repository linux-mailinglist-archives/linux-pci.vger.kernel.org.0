Return-Path: <linux-pci+bounces-31999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B351B02C99
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 21:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FD83ABBC2
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8F283FDE;
	Sat, 12 Jul 2025 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="UULzpoNC"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6135946;
	Sat, 12 Jul 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752347904; cv=pass; b=jKHkuIkNEzLeVNiyVhmqQgiDnrQfCwDGSEBOAPdbaLcfcrsENlBQdqhCnTDu9h0OP+coPhogMHa2v1XjTZz8Fu+3ZrdcIIYETXuNU0NJBPqAN96Joi950ssctoJDvUic9pnndSMK2+lpO6aZPV1Z/pkhBd0qyo3rI+FlLwiBeI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752347904; c=relaxed/simple;
	bh=KCw9gDmDa8Y2gno2y7i7oAs/m+XnHgcATjygp51m4Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fnf4K8cK5oZElWXfdivzAwdorXbrlfLjmJF5gFKofhnjGtEnRDqQOpUln6FZG8kRLHk/u7hWaXgID/U0MS32gly8pNixAQ4O7+kLsDvXCknDg+i8/I5jeYYGhxNMddgc9zuKXYapyjzI3hzw26lxv1krcyS/b0fG0y78Npt+eOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=UULzpoNC; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752347895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nSSMwY6QoRfCv7c8n/fwv9DdtZ4wlMS8DfNS5NGnSynC0A1xa5a+RfN3M6bg7YH/NcW9DHfMDRULO7iOfy7KtOHU+cC8vkyXX21Un5VE840iGe+T/QFqkuAD/DC1xIHKsdcjTFhaD7y5qCwqEPSJqCF5QASW/r/4HrClZW7Kq7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752347895; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9+SeksEJ/B3oHTmDXitUpaGe7BOdYyJw+AFYp5mL8xg=; 
	b=hTazcVIgPz4ZMjQFNIHUI45aKOzeZsobcNxZddBxFSA8IyWMHtF3Ijun4Lar3ficu8npVzFCL64FQKZdXmJDrLZcSIqlDvynY+Q0/RKJb2tqoBoZT+dxxivCavhauJAThG/L/c9gAlOaS3K6Sl4/CrvRvH1wmqM9K1PkAgBj4l4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752347895;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=9+SeksEJ/B3oHTmDXitUpaGe7BOdYyJw+AFYp5mL8xg=;
	b=UULzpoNCpzcKryXoJdv8lA2NrO96lXYnyMIistFO2TbdHr5ZrXZQy7Fszor2gpyR
	ogygrNCplebqedGOC9HywNPS/fMTuGF5fF+sMcrXqUrgJ432meNhee0nEbYr0NH9U43
	oMcZgzZxwYsyOLgS8I0/rs4AU7BLN4e6j8icWj+E=
Received: by mx.zohomail.com with SMTPS id 1752347892628997.4685098189007;
	Sat, 12 Jul 2025 12:18:12 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: bandhanpramanik06.foss@gmail.com
Cc: ath10k@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Date: Sat, 12 Jul 2025 22:18:05 +0300
Message-Id: <20250712191805.5238-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122753e21b1af32df72693f2c21c0000b81c9656ebead32314845f469649a9d58a1a6645690a316cce:zu08011227d26e261832766660a9590e3e00003488e544a1fbd2c6ea5fa976174713694cc20ba307517d9038:rf0801122c8eb209f952fe2d65418d80310000afa7de5bb988db7dd39c0f1f677807fc98d39697c23099823dfb1141c821:ZohoMail
X-ZohoMailClient: External

I saw problems with Atheros on my Dell Inspiron, too.

These instructions helped me to reset the device without reboot:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1730331/comments/40

I used modified script based on the one above (run as root):

set -e
rmmod ath10k_pci 2> /dev/null || :
rmmod ath10k_core 2> /dev/null || :
rmmod ath 2> /dev/null || :
{ echo 1 > /sys/bus/pci/devices/0000\:03\:00.0/remove; } 2> /dev/null || :
sleep 2
echo 1 > /sys/bus/pci/rescan

Try both scripts, one of them should work.

If still doesn't work, try to run original script, then do hibernate, if still doesn't work, run script again.

I finally was able to solve my problem by replacing Wi-Fi adapter. :) Here is my new Wi-Fi adapter:

[    7.136347] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 3160, REV=0x164

--
Askar Safin

