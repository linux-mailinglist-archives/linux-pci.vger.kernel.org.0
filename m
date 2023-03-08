Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621E6B0247
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCHJEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHJE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50142BFC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266258; x=1709802258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5gDd/B2Yq1tEK5yBf6Y6lCpaU94/+jEDozwfQvzxWI=;
  b=LRFhf2YB8lMAQTVJJdyZozCRcvI5/+qtn4dCZNcYO4nMV4uesuOgS9xy
   kDFtY35jcKh6zrqGVOmI21q8YT7oavY8fqR63keFwFL9lp/SVzoaEQF3R
   RvLOseM7432jKCdLwGc4GEow4hfckOeQwipY1Qo5BTeZsxysUSEhD6cXH
   CBKW/RAwV+HH3W/fi0EaQEVg2iihWydripMPa7Zi8YcZV7WBi50cXORPk
   FJBHC6Ps6bjJJEGrPpKvDbjOeMcUcODVXljwnWyRAq+YN0GaAiO7v3Msd
   Ju3hO/EFKR7jUImKtKqcy+OsCfnaECcEyH8QVqlVOHocMae7NNxDifJTB
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:26 +0800
IronPort-SDR: sVh2xhd+aeg6JvbJEmVtezTYWlb+oHh990b6WD7tXsR1MI/ntksHspGHmUxUk9BF5XF/ykkSvJ
 22DeWxCgwFB5DKlXhFcp+jYCVxteVdcQbSzYMilkENr8ODKN0x5yS7P5fOHFxrNvH92SQL2JHe
 pww/rvhOqXhPNtMs7DjIkA69ihe+O0IpR+0FHfhvSvT1wVQ35/slqL31vISOGjUyYNytDYaNyU
 JqfO/QhY3udO/jj/FfHwsSiAlirBxBT7Je1FK639b6EM1KTe9myY/5gbZ/ih3hgbCUI8/0DUFM
 Ixc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:23 -0800
IronPort-SDR: HXfdFrh9Y3qhtIBz5tkrDtR6//Hb91oUmG038HA6uA1JC586ktjWcsGKloKr6phj+Ea30s0mL4
 NKefYRkURTZijedipGUzLzaUkYbf9jV1TTU3Aq+WHn54FNSrdVQ5SOM9Mbqt1Dq5NLZ3v2mM13
 ggX+nFdGZriSSx+slwZl5sCoK7JAP6mtNZiqko9Hfsrg6FxRWi2fKuW/Nzic/pmAJcg7yk9WJp
 Xg6bGo3/6xlIj7KM3WZR3G8M2bZegJyQWsiQaEkuNQ0LzKyteHkNboW3CSDrcHH73ag0Wd080b
 IX8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZ623b3z1Rwtm
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266205; x=1680858206; bh=s5gDd/B2Yq1tEK5yBf
        6Y6lCpaU94/+jEDozwfQvzxWI=; b=NFwk+cOJUi7drX904Q1UIP+jqsU8vEU4ix
        WNvmM4M2EkxP1Q0K35Wki1exbrT7RpjWJUeSr0sEGwgF4d0FSLC0hgfXhIwPoyN0
        tfgoPfewUw9AC0BhDg4oGmiJx0IA3+gzcKtAQY7UvEHfuOJh3sTjUHLwXIQNWlZ3
        6dfvcNqyu3ImDP6Gs4jC7uZtV6pbEgffZJySBXIPxiXFNmeqtoz+uPc1VackVkRU
        giIJBhlqnfSy87P4SB64gOSyqzQPoCrenPu4h781I8cuMj6iw71+87SbLuS92yhk
        xFyNwAh4kVhKCpg6wDTmQYbn2zXitBWapzZfrT+e/Ko1tpgGHvdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 61eLRHYxaIh1 for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:25 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ41JNLz1RvTp;
        Wed,  8 Mar 2023 01:03:23 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 05/16] PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
Date:   Wed,  8 Mar 2023 18:03:02 +0900
Message-Id: <20230308090313.1653-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of an open coded call to the tx_submit() operation of struct
dma_async_tx_descriptor, use the helper function dmaengine_submit().
No functional change is introduced with this.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 557fbb91c729..3dce9827bd2a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -163,7 +163,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_=
test *epf_test,
 	epf_test->transfer_chan =3D chan;
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
-	epf_test->transfer_cookie =3D tx->tx_submit(tx);
+	epf_test->transfer_cookie =3D dmaengine_submit(tx);
=20
 	ret =3D dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
--=20
2.39.2

