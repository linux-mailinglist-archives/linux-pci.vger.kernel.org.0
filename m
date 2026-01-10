Return-Path: <linux-pci+bounces-44422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD665D0D234
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 08:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AE4303C9A9
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01434A77C;
	Sat, 10 Jan 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJx9UTMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B413491D3;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=eyt9WZoBFiAHjXQDn6jbg1bKIq5UgQsurIGgVeVa3/1G59e9q7GL2ZDgiYHWyA/1XmQYNg6IjGkgsQ8TszkcuSAiId/XL2WsP/MmZ/jqDCamW0l242wyW/nx46RQjHpIriJqCb4RfC+3TajVFn0yI0ciiIFN64OPJA6i5qe+274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=uwW8257EhmouZpvkVKGgdUbE780fBLOlGG44AztWPJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVNqXCCWp9ssuGRmx67FaECp1DjcTQYTQ2SGkrcplqtPEgurQSZkUxzUJLSs4JIv5LyxziJASycjHNbFyZn1+OsrAd28mFlWgUw7EsIkIEzdv6lPMjx4u2njpM1AcYRbnXBPON5Js+bRbxQCrrXjZJcD4Fwo6G3tHqM4VPql2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJx9UTMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F7E1C4DDE3;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028226;
	bh=uwW8257EhmouZpvkVKGgdUbE780fBLOlGG44AztWPJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kJx9UTMpx7TrzIfOrJ4DfnNUKzqW1idj0HevDma/2mXKgfygJTk6fSe01IfYyRgDR
	 RvZeI/1oMYW6AEPzZegWMrIAerRx6TJ8eY6n3DA18RXbirjiISsDv/rF80kQpQNED2
	 84z5SbrnFWF4yu411MGAQpCe/dWyIVzi4pBsU99IIAbh2BvIIlPaTpg2/+1iXLX6km
	 QrERoFCiT4v1LNQV6s3NKCRJs2xG3dkjAZNTda4NlA/kTGfj1x0WLQgXd/5Uz98GPn
	 zlkhOjAIAbEGPUvZzGAkeq7c6LjX0XhwBPR8N81kANy4zF/ksudsIo3T4mEF2A7Agy
	 iM56azZqmToqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2651AD277D6;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:29 +0530
Subject: [PATCH v3 11/14] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-11-4faee7d0d5ae@oss.qualcomm.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=RWekJdEKdic9EZu4rQGv0fBKORumjbEDCuN8SBTLMc4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg+TRCoMWdJ2WYv0cU3v57JOA3eOkhRvc9NM
 QkwIwf2HymJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PgAKCRBVnxHm/pHO
 9bSxCACn3aeHjikwTH34ED8GMiwZYePyUD6dpLxapg7iDk895cVBZ1IZOGZcvaOvrNc+F1Koz76
 PsxffieAiZaRoIL3PpDMyaQ49vZ+W/mecd7Q9MmnEPWcU7PF45xDGYGwcU9173vd6GbHICVxJ7a
 SHWSjXXiP8m3Jmu53tOznAuVAz2qfsbzn0TS3YlhlGRHhi96AmM2hux0doiV1dd0iF40NAEYwXd
 +n+dmeVZ2v8xXKF0GOHEzBlhU64ECcqKroJegmOdLcwwUdESsfpJS1GPP2IBN8jngvWuLIBasEn
 LSrsJ1XW1MpT922zo4+84wcVpbNDhq+/x0oz6xMM3qWWq2Y/
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
spec, it looks very similar to the M.2 Key M connector. So add the
"pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
to reuse the Key M binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index b65b39ddfd19..9757fe92907b 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,14 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - items:
+          - enum:
+              - pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.48.1



