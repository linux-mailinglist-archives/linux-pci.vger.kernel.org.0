Return-Path: <linux-pci+bounces-42455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E138C9A6C6
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78EBE34636A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D7302153;
	Tue,  2 Dec 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r8+XFw/9"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6430216F;
	Tue,  2 Dec 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660243; cv=fail; b=gUowAevKBVcY66XkyTlWxCQfVPirC4yAvav8VCrbvDg5SsrPWq0oJa9Oio03Ob1eZv/FT9X3yuZdsrZVk4mXCVyFDIzE2jeFcFv5G59RZjpW3gJLhdk9zlI4hGMHlrdWZGQOx5uI+e5WQh3lQH1wsjmzdKTiXHktp0DT+kOPpV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660243; c=relaxed/simple;
	bh=O+25aDE86dw7kb8Igth+/Ni3EWo+0WC/Hj559OO8YVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqFd010zQsS7WCp+zWaMoUYzyJ5+1ZVInwsXo07OgzMSi+/1wXEWfLXxOTxFKAJQKa6zld+jDq+yuFgJ+3pT3WYxXzaNFb4Ttb9FrrUaRIR0n3WU3Lux1OMQ/6p+QTvz8bGuTLps1BGj/T5iQvRIIhu1Sd9iFTsYHk1hjYWzU/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r8+XFw/9; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDKOUwbwVsnrCWHP87rHBuIw2GasBM9hhElwiXrxJm3++Gk7qHvKt8nyHfAHBfVJKYiPpEUhaJPFJxCgglOK2+HStmXVnS7Q2p/8+zFfvSr1WYMlQsey1wPEl0UUQ6XRUILHTI47GQoAZPwcvszathcEnj8rFWDovy7re4rb1ZkOEp4n/l0/7ugbksQBfeFlntIE1SjxQhAvRLWMUgNs83qQO9NUxRVeWtW60lpPBHDvoXHYEkDSc0sDowMga3oLtCxype7+TaN44po48/ZA8EyMhTahUDgbgXPwzg7mkivi2cVqRUa+RW27YOqDYQtWODAb4W+DnMkptMQc4RyQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKApDRV0CwAGwCQhi8dzR3dNnpAqxilqtJChT0fy6BI=;
 b=VPX1KPeHWghHBfKf8bRIjrfwHoqWd2IC6S/JQyQOC3qsaWgAnO5vOap+Bb0RFts0eQqKhZp6mDfxixHwkrayY9nJDu0Fo9CV5/jtV9FHg5r0tkqsDhNU3wKbjbsQTejH5ucRfkjFZ/AdzcGuuIEOEKau8djA3+URQq2gEEa6IhUafBydIjV/4L/xlruFfvSF/tdmBebBV52u3lIURxqLVCKqD8r8VArmab75PCZf/3uLcl4cFq8pejl7iAoMApE7NERt8z+8HK0WqzJu+o6cS8kgn+7Kq3ggZu5LUc1yVSzAQPjab5XOxgVM261xDWeEDc0J+vHJlMnHMeAWDsSBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKApDRV0CwAGwCQhi8dzR3dNnpAqxilqtJChT0fy6BI=;
 b=r8+XFw/9arefx3q4kSZorGGFHQBm8vB6gp4pDwPHzENIxvu7WAks0OGi7N97gmdeaQA4dmDUikkVgOQd2LQwqv/jI6yDpechEIz+7SdiCt/qNStEy5QC/4o135zyCmGqLxhHSv5sMR0de1LrmeY6DP58eRlEZeOpcFzOiKtpiPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:53 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	stable@vger.kernel.org
Subject: [PATCH v4 3/7] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
Date: Tue,  2 Dec 2025 16:23:44 +0900
Message-ID: <20251202072348.2752371-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a80287d-829a-4fb5-6f22-08de3173bf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5UZvf41dWVA7RPq+i0kumZiqER9+T8MzfwTaF09YF/eU3DPWy85gbd2yCpA?=
 =?us-ascii?Q?ULDuwfOraY5r0Y6Ub5aDKwkYJr6CXJqBjTb8sIfqJfr16By1+VfHoB7ePkJJ?=
 =?us-ascii?Q?tCOI9xArZMANCCgWweutxPP4PQcsirsfHFzpVzZbL6qGzxTG2Z+orwZUEczj?=
 =?us-ascii?Q?M4FnMmSXC4KpSkW0IGZs2+X00ZWYdA/GeTNsddN0hReqZfVIDkrsYD5ZmFlC?=
 =?us-ascii?Q?u0dpKlI74zDbflo+MxAFkxg5//lJD7pTSRkgaFPBxn/S1NQwIk6qx/CA7jaE?=
 =?us-ascii?Q?8gO4uyLwyD/ROLqQSZ7GxYLl1Aa2/9DWFBoMvh397r235Q+Agsc0ToohjMFk?=
 =?us-ascii?Q?FD4JBQeuAGa8isP+BhoI8pTpiH6rE/GArSERGozZUfH0zeaXDpTiQixKwuap?=
 =?us-ascii?Q?a0EI3Dv0kAh0riQeDkInxHb/CRx0hJ6cXsLPfZvuPfqpbivQ1AJes7LC8DE4?=
 =?us-ascii?Q?98NZ8tvnkEyaRwalIscM7FfKcnHvuovCqGGV6xDJFzuBwzKXob0f8lVakUPU?=
 =?us-ascii?Q?/hYyIhXwKJwtwzk01ceZs0VxSVRlpqlbRdLokOVBcCicpeqqLN4uJ5T3cvX5?=
 =?us-ascii?Q?kMKNxyv6dDzG0a7XthEvIB7b9vUjHSrOE545xSs2vZ5XsJvFFOurzOH2OvMy?=
 =?us-ascii?Q?KVd3NQpNJ1vzHJOmlra7cGgDzzZkvEFqG0XtDQudTnc03etbXPtYYlZQbHlT?=
 =?us-ascii?Q?qG9ABtJVbqeWkDKIlF21b43tIomAqJHfKNsP7gtzWBIxsp6P+mq5QD0nH3F1?=
 =?us-ascii?Q?JtrfNHH3YpaZJ/3w3bumj+yTx0plaBxZQa+1RM0ADOFluC7BfyyAPQ3LwP+p?=
 =?us-ascii?Q?VPRxr88PqJjYM/ws290Cj49HMBY8+kJ5z/CQ3lkMrRp/CqVA+pmxvVCRqIb7?=
 =?us-ascii?Q?jP5N4uQOpwDeewa71PfES/taD+1LxxTP28Yi+QZCEXijiNsqeam90+mDtm7l?=
 =?us-ascii?Q?g8W1lQkQTxrLTfFgWDSLb9BFlyv/W1YUw341HlJ6KeGpVOpM3Z1zKD+r6gFk?=
 =?us-ascii?Q?WqUS17ENj/3WbVUQRPkZ9wf4raHOqByl3aFVk5z6NZweBeO1bjyEyAgYGjo1?=
 =?us-ascii?Q?RgPAIHAt0KMn4u0cFifECuACLMPgIY/fqw0IA77d+k2U+5/KwgQJYXE+X1gn?=
 =?us-ascii?Q?tFejWcGXaYbRtfB+5odjlZTTarZYLqP3gA+NqYIs8zer6VIpOcEzZqL8gfxD?=
 =?us-ascii?Q?k5Em64Q/d2cfKi3qvtX03cQKSKPajl/uX5eJ30KkfoD1o0yQ17XG7pyuWaz7?=
 =?us-ascii?Q?wTBFTW4OBey0zWDhBaDL7GRLTxvXzr3YlglOrR7qkrHM5D1jXM7duPUzbI5K?=
 =?us-ascii?Q?qF6ZJuKZpO7n2sO8yTgRYiqQmyO1Rq4H1qIBMBw4ubF9x8qSaDJ4d+nwsawg?=
 =?us-ascii?Q?9dIUdHooz7s6SEtROhNXyg5NPgHMZBVafzLF2PjcAI0KNo5ILMKswRSwgrqo?=
 =?us-ascii?Q?MudybFt1rzoMsc7y7yewEi/jtOjecBcr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SS1n6htDAfDwotNUUNyGG6L0JxDOGejgvoTJHtEhT7qXag/9LqDr02fOmZG?=
 =?us-ascii?Q?KujXDzBG6sos4x6cpvnNRxwpmHp/WXhX6q5NldWVWWGKL+ml8AjF0g9C9a0R?=
 =?us-ascii?Q?OjtoIsVLNVd7lDKK3gN6DANmvGQHQ+QnYmVUwqDF9EXgWHOPt8Lq++rhST+D?=
 =?us-ascii?Q?9bWYOwgCOorTU/tR7cPRgP65OlEKg9jxSRGe1TAHiTLG1vQxd9+1QV+CkzDf?=
 =?us-ascii?Q?z/Ab7luSRjmmV0KmbR4lrkn/O49SjvkDAiIOajX6U5H9VZ4FCTsMquKlfJSs?=
 =?us-ascii?Q?yqp9SGTi4rhf/w72Vqe0Q4tOxfIx73Et9eehLXMHTpgmquOVKg8OqGlBiYab?=
 =?us-ascii?Q?RXe1QMSR4akZ1rAq3jJrUdn2C28NhqLL7UFHGmXsgBmAmSU1X6R8WUWV+1IU?=
 =?us-ascii?Q?l9mPdcnhPhAXN5lNpqO3HFaaY9SvmCl0XRctrsWx2IoZQZER0blbbmNbqlu9?=
 =?us-ascii?Q?FY/dbKQdF5KfebLJwg/s54vdF5iPyTmD534SEWVkXBhc+PmL/wLol+dVeQaB?=
 =?us-ascii?Q?q2P82n50rN9LD09p330dTp2nVqQDUNFm5NXhnROxijV6iT/IRKIpx7ScB1AS?=
 =?us-ascii?Q?jYjnfovHrxhz/eN4ryKT4IHWBN5eVOgw9WgE/83EmbahNScG5uPolRUptPOJ?=
 =?us-ascii?Q?nFiyHe4tYIWVhJ9YDb7Fd4TYITZkdnQkmFMZZo6kod66Lh0QeZ1fif45JgYL?=
 =?us-ascii?Q?Cwx3/X+OCtqjQ8jvpNmC4cJeOaHhzUmsbMQvkiuPjNTPzUrn5i6bcFgio9Bv?=
 =?us-ascii?Q?pWmEbFtBwsQzDy5dDXpPwKxGXu1y1+RNG4xtCIFmNaQPmNcWqJyuVQipWT2u?=
 =?us-ascii?Q?0OFn51wR7kJBKbxezz1KcMWWSDcyCulCPTldHBXphcbJ5NqNpnJUKFvXIHQq?=
 =?us-ascii?Q?e8zIO+YAVAtm55wt8dN9G2bNDhtD1EHzjgPkDqL7UQqoM3SeVI8+lWy66C9+?=
 =?us-ascii?Q?XWKUzVbe4ZZlHXxdqKAYUjzIxGNG9aJB7f671n1M904jPcUxuv2Y0lYdo9OS?=
 =?us-ascii?Q?8TqDUbof0cueR38Rsq/bLFn8uSI15OUktphyBTRJE/1pGr5r2wxq0Pgvn84e?=
 =?us-ascii?Q?inNzset3imwdjOyWFgdJ1XwB5Y5OMYS9wIMk0WJiJzWYfOVo59a8y5zGGCjj?=
 =?us-ascii?Q?Mgz4oqYiDem8NP3RVC+l5zpZWrFzVA8l1llANsR8kCV/l2YzeT/FDp992pMD?=
 =?us-ascii?Q?GehoDGgcT5q2ffXxVriWA7uRTqe2YVgGfgZkSOgSQPoTMnHCZZ8VMdSLGk+1?=
 =?us-ascii?Q?zWYCeG+B0ebPMogdt4Nwws6yHHs4JoD/8g5nTMdVPWt8sSsG5QUGuU8g9rEN?=
 =?us-ascii?Q?R/IE7XGLvfw5qlUnCJG70wI86RWjm6I3bmu/gWXpxKX89X0lyy7Zu12yToUm?=
 =?us-ascii?Q?N+T6f1IoDhpXIPMWU572hmEHv3BYS3UTr2cxcWfv4Hh3DIYrXbOUHmAOKrsV?=
 =?us-ascii?Q?bi53e3biIHY8geaSWKpxIh37qdM3gf30gKb53p1pXTpFJwxc48/mMXqEUgx5?=
 =?us-ascii?Q?zO0xtg4nT+Pm2zANh0dnBimZ4FBo4Ec8IoH9elUrl9xdHKeVgsL2AOiaGAIK?=
 =?us-ascii?Q?1oDE+x5NLbQcffz8r89Hrh9ZMrLcJPKc7efDmZE8iOY/PGkLJiqTekeAb58s?=
 =?us-ascii?Q?CLlyBoC+N49YOQUlE8tyYKY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a80287d-829a-4fb5-6f22-08de3173bf4f
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:53.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajJh7WR/pCL/pRAZKTtZFExCWYzeMGuwomsqi7yQmlUVmPBg2lOgxX3davHK3AAVMT88Yo8ephs04WoATDz0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to perform later. This leads to an oops when .allow_link fails
or when .drop_link is performed. The following is an example oops of the
former case:

  Unable to handle kernel paging request at virtual address dead000000000108
  [...]
  [dead000000000108] address between user and kernel address ranges
  Internal error: Oops: 0000000096000044 [#1]  SMP
  [...]
  Call trace:
   pci_epc_remove_epf+0x78/0xe0 (P)
   pci_primary_epc_epf_link+0x88/0xa8
   configfs_symlink+0x1f4/0x5a0
   vfs_symlink+0x134/0x1d8
   do_symlinkat+0x88/0x138
   __arm64_sys_symlinkat+0x74/0xe0
  [...]

Remove the helper, and drop pci_epc_put(). EPC device refcounting is
tied to the configfs EPC group lifetime, and pci_epc_put() in the
.drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..49ce5d4b0ee5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -644,19 +644,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1406,7 +1393,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1446,9 +1433,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1464,7 +1448,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.48.1


