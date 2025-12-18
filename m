Return-Path: <linux-pci+bounces-43330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18676CCD973
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D931630806BE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FF347FEE;
	Thu, 18 Dec 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQTxlBwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23370347FCC;
	Thu, 18 Dec 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090600; cv=none; b=azcHcpplcupNCWR8ckBk/vP4mXQMYXbuNYqrGrh7RqVqNSt4lRF3dQsYj7uZKZFCKn3ET12fMNunZnjoYeiLsrJSD6vcgiN72Tg67EwJBS7zpfpJMDAWm3Q+Fe+90MqrW0CQ49aKag1Sepq/MGrbEyZv1mwpx65x2S6n+feEK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090600; c=relaxed/simple;
	bh=TsxZK5bCnR6PZQC6R8dwLa7ysudei0fI1u09mPFxqBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzQynWfj8yelTt/PYb2T3AKiRHiaIrnium0JJzUJiE0UFza21R+hc/pbc2AD0n7jEOlgZdOyfO41qE4fa3fGqc0oZgb2uJn8OSy0mPGyP3jmqEK1CRy1DYQXTRzmAPSLkSFzp4aSdcHDX2xlSGQO5ZoxtJid0NUXC3Dc8TK3ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQTxlBwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EEDC4CEFB;
	Thu, 18 Dec 2025 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090600;
	bh=TsxZK5bCnR6PZQC6R8dwLa7ysudei0fI1u09mPFxqBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQTxlBwRZ+IIvF4w2qBWfI5wbxrD5gD8G7TDJrZayTGJtEhguYs39KzEqkwk+vPfO
	 EUV05mVsoKWwCL5Qo7jXI7ySRQT3W4g+KM2T7y3ZeGgsLrcCvo94JoBMzVWOtClttk
	 +NSWv9v5ij6ExVNOcgaChIHoevnK2Tym/XA9SSvcrQKcQ160gE9qAN5CXyOoEUabJW
	 ZBZR8tjUwprWrAlbRrxHoTU6knUJfpWafbJvQMXskkk4whknoF5KSyoUfA5B9XNG15
	 MyYmLtoJv1fEGzHfQ78QGqczSMAcTRK65otgevWUPmb1G3LBS94zUbz+2Qa02NJKT7
	 4reVm89GtTMYQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 5/8] ACPI: bus: Rename label and use ACPI_FREE() in acpi_run_osc()
Date: Thu, 18 Dec 2025 21:37:36 +0100
Message-ID: <2038315.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5049211.GXAFRqVoOG@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use ACPI_FREE() for freeing an object coming from acpi_eval_osc()
and rename the "out_free" to "out" because it does not involve
kfree() any more.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -293,7 +293,7 @@ acpi_status acpi_run_osc(acpi_handle han
 
 	if (acpi_osc_error_check(handle, &guid, context->rev, &context->cap, retbuf)) {
 		status = AE_ERROR;
-		goto out_kfree;
+		goto out;
 	}
 
 	context->ret.length = out_obj->buffer.length;
@@ -301,12 +301,12 @@ acpi_status acpi_run_osc(acpi_handle han
 				       context->ret.length, GFP_KERNEL);
 	if (!context->ret.pointer) {
 		status =  AE_NO_MEMORY;
-		goto out_kfree;
+		goto out;
 	}
 	status =  AE_OK;
 
-out_kfree:
-	kfree(output.pointer);
+out:
+	ACPI_FREE(out_obj);
 	return status;
 }
 EXPORT_SYMBOL(acpi_run_osc);




