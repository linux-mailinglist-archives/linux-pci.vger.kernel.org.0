Return-Path: <linux-pci+bounces-16521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652459C535D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174761F2133B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606562139A7;
	Tue, 12 Nov 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrygTCVx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8B20B20B;
	Tue, 12 Nov 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407152; cv=none; b=C+EdKJMBKr8hckdSc88TTLnPGPJ0ut0ouIjEOkzIlMiP1V50yf6fmKHDkX2687gfGd2tyN7eQKmD5H3zZS3g0o9jSo2FETK12JcGRbSczIzSzJLOeEvKa+p0yVj0cZiy9YLuIyT4/mVHgMH0aW9Snb9hs+ODbszrsY2MdufHflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407152; c=relaxed/simple;
	bh=hDtwxlx263Ka4x+zd3cQnDTdGx8NUTZ76VVOto/UNHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dErmzHwA/z3Z8xXxP4jj5F58jritvZhzySa8p9sTCh4t/sowDSl9f926fxEj5ghhUlRAALcf3veVuCMt7nEhTychOTWfud4bONenSyrE6yroPGXQZoSxA0sj7JTNU5GvYPuAUnAgfogfEgitXt4xujMx/otG9z4OXcFEl07jtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrygTCVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B8C4CECD;
	Tue, 12 Nov 2024 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407151;
	bh=hDtwxlx263Ka4x+zd3cQnDTdGx8NUTZ76VVOto/UNHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrygTCVxO8Ug/Sqh08YMfEsbHdJWvaU+4DkKvprpp4RXqbu+S8Ijzm/FugVZUiF/b
	 Tq+rDTnODyp1NwRVrWDXjLxfu2jAuj28ZBJgaMg/DSYfP2Lc4vtLz4RkPJLDB6pL99
	 iXLuIZUDjQ1fFVKbyHlA3KaIez7Vjkbf8KtN0v6tlJ8KviYJ5Q9UTAJpGs5zoMNA4N
	 rGNyqymfUyTOgl614+7GFCrkvWHASyFk0UbXP/qQ4Ull2iTahUqgtq5LZocmjMQcuz
	 MD+zcxQNtsjKQQqEx7vTseLidXj9apzU7aNjZ+xMhbd6bq21aZeHAOyOFt6lOok1A3
	 2vYkxv3xTgCOQ==
Date: Tue, 12 Nov 2024 11:25:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v5 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZzMtKUFi30_o6SwL@ryzen>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
 <20241108-ep-msi-v5-3-a14951c0d007@nxp.com>
 <ZzIYAIGjHQJqR5Qt@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzIYAIGjHQJqR5Qt@ryzen>

On Mon, Nov 11, 2024 at 03:43:12PM +0100, Niklas Cassel wrote:
> On Fri, Nov 08, 2024 at 02:43:30PM -0500, Frank Li wrote:
> 
> Perhaps create a helper function so that you don't need to duplicate it.

Something like this on top of your series:

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 8ede7aded03ee..b1707b4425432 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -656,16 +656,25 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
-static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+static int pci_epf_get_doorbell_addr(struct pci_epf_test *epf_test,
+				     enum pci_barno bar, u64 *db_base,
+				     u64 *db_offset)
 {
-	enum pci_barno bar = reg->doorbell_bar;
 	struct pci_epf *epf = epf_test->epf;
-	struct pci_epc *epc = epf->epc;
-	struct pci_epf_bar db_bar;
 	struct msi_msg *msg;
-	u64 doorbell_addr;
+	u64 doorbell_addr, mask;
 	u32 align;
-	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg)
+		return -EINVAL;
+
+	msg = &epf->db_msg[0].msg;
+	doorbell_addr = msg->address_hi;
+	doorbell_addr <<= 32;
+	doorbell_addr |= msg->address_lo;
+
+	if (!doorbell_addr)
+		return -EINVAL;
 
 	align = epf_test->epc_features->align;
 	align = align ? align : 128;
@@ -673,17 +682,28 @@ static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_ep
 	if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
 		align = max(epf_test->epc_features->bar[bar].fixed_size, align);
 
-	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+	mask = align - 1;
+	*db_base = doorbell_addr & ~mask;
+	*db_offset = doorbell_addr & mask;
+
+	return 0;
+}
+
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	u64 db_base, db_offset;
+	int ret;
+
+	if (pci_epf_get_doorbell_addr(epf_test, bar, &db_base, &db_offset)) {
 		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
 		return;
 	}
 
-	msg = &epf->db_msg[0].msg;
-	doorbell_addr = msg->address_hi;
-	doorbell_addr <<= 32;
-	doorbell_addr |= msg->address_lo;
-
-	db_bar.phys_addr = round_down(doorbell_addr, align);
+	db_bar.phys_addr = db_base;
 	db_bar.barno = bar;
 	db_bar.size = epf->bar[bar].size;
 	db_bar.flags = epf->bar[bar].flags;
@@ -1015,9 +1035,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	ret = pci_epf_alloc_doorbell(epf, 1);
 	if (!ret) {
 		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
-		struct msi_msg *msg = &epf->db_msg[0].msg;
-		u32 align = epc_features->align;
-		u64 doorbell_addr;
+		u64 db_base, db_offset;
 		enum pci_barno bar;
 
 		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
@@ -1031,17 +1049,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 			return 0;
 		}
 
-		align = align ? align : 128;
-
-		if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
-			align = max(epf_test->epc_features->bar[bar].fixed_size, align);
-
-		doorbell_addr = msg->address_hi;
-		doorbell_addr <<= 32;
-		doorbell_addr |= msg->address_lo;
+		if (pci_epf_get_doorbell_addr(epf_test, bar, &db_base,
+					      &db_offset)) {
+			dev_err(&epf->dev, "Failed to get doorbell address\n");
+			free_irq(epf->db_msg[0].virq, epf_test);
+			return 0;
+		}
 
-		reg->doorbell_addr = doorbell_addr & (align - 1);
-		reg->doorbell_data = msg->data;
+		reg->doorbell_addr = db_offset;
+		reg->doorbell_data = epf->db_msg[0].msg.data;
 		reg->doorbell_bar = bar;
 	}
 



> 
> Also one function is doing:
> reg->doorbell_addr = doorbell_addr & (align - 1);
> 
> to align, the other one is doing:
> round_down(doorbell_addr, align);
> 
> Which seems to be a bit inconsistent.

I now see why you did this.
One function is using the db offset, and the other is using the db base.

I strongly suggest that you rename:
reg->doorbell_addr to reg->doorbell_offset
and
PCI_ENDPOINT_TEST_DB_ADDR to PCI_ENDPOINT_TEST_DB_OFFSET

since the current names are very confusing.


Kind regards,
Niklas

