Return-Path: <linux-pci+bounces-2385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E94832DDB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777D31F24E9A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7555C28;
	Fri, 19 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dibhZG8O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541505916A;
	Fri, 19 Jan 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684369; cv=fail; b=nDJTUnS52liW+IjEodcWxEpywcQ1HuD0NFPIXuM1mSf0LTPPS/zyVV3Nb+QpsvHJvdpHbCHnZ1I6i1ZSjFXTkrLhiHBNfalwpiTgdpSEnBfj0gUzBjm31QSjzBR+jk5zfyqTN3gkLJIP/+p2WSKBhRfNo8ld3nF94AeYbwVHKC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684369; c=relaxed/simple;
	bh=Jpr9D7bCbA77S/+/IKSwybqJ583yF7AOkbKGaz6LVFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tf9SQbx9PPOXxDVfCFw+9szkd7izESnYO9uP8E6zNbSsgUB3SpafUIx+jLlRTfIKJMJzMb0m7x2rqf2nHCPdjVBUwqc3nQEgXjqQ+bh/Mfw2raSKHFwFGNIhc/+DgJP7fps7IcSl1gJui0B0gZfFR/jd95XLJJOg7zlVk+XeBCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dibhZG8O; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuwOFJYF+s0Kz8q+r4zhUGGTATRh6s+rzfv8Pgqub7ygGOU/rJz/GstrINzBG+xZrhKaR/zg1mDgoxtRT7HcqaL8zSmJkm6ZUi4l98ccxvfefKf012MVmSzPrJ5vD2+qPVJKXxGzSkh27S8Z57zHnLp+krFtabPRXfAasJvKylx/vvCpjONC+l0TUOVODeK0bjuvpXYMEEokQ9TnU2pYz8GUr2IJBMZZDW3Pf9u57AlZ4Q17TbrVtnUnazpXVAwcEJTUt+e7wnWoUR1+Foxv01M2qMoo8SiTGWpm4B9EiLtnEPCGGqJKzNrs8JLunz6MXjdPvnFodhzm3/ytC9xsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue7Z7S/Gg23M28vNKSkjOcn0qRKsr0AUtEpnelHAS5Y=;
 b=PbqPGiv0dU811xBGsjxMZVZixfLkZLBmrjGZmBwFBI432NORKVuvfNUlukgJ6IXuooa42JXqeDbmkDe7zYvsVcYSI+kxb6J0uSqSbd4PMDDYWKjTPqRlp+1Azxl3Gdd7GA90KheFFyiNnJTxViiaapVhQlqc4etKXYOjUXH3zQi2eOstV0ff9np8vSOY2T03nI8ApI2iKbgvjdjNydpDtoVc8psjCQM+jh6vK1yR7A9AVks9+qBVHTCmzpwz+fcPXwuYd69fTve/Jn1ktWPQBIlPUZD2RtUHG7fT48kei+U9osLVkXdk4YX6DTD8G+p0aEa4wwdlEkUDCgKz/afzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue7Z7S/Gg23M28vNKSkjOcn0qRKsr0AUtEpnelHAS5Y=;
 b=dibhZG8OIOiKTTm+oa448x4rQ/wX7EVc2DMCv1MRoJ8rXAUDOoUrbAz6EelvMAT52l+ue/wqtr7xOnlY6j4yExuB/fn7KY8PW4NMgI4/9XGs7NCsf9ud3pHsZaEiV8CFjTiiLLHO7aTcQ4lts2cFgGMyhcn3DRRemqXVJgx8x8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v9 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Fri, 19 Jan 2024 12:11:17 -0500
Message-Id: <20240119171122.3057511-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 436e6976-af4b-45b5-bb3d-08dc1911d712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yP74r7Mk8Dm7EWNo/xKXhu2kKuytq7gpJ72m0ltkhM6JdXwZcnHxODBM1z/GFiSY6Dv/Yi5s6f2y9iz/uHXyO8KCBq51qBdZ8HuQQn9C3fNKLzt7duQqrkWTdf86Ya/Jzebwi4izNF5J6Y5ydK1TZOxGn0JmJnOwkzAo4KdN7Dx074EFOpet85Z+SnTuEfItqN5r8Zar7s2UIxroF17/qriv0k+yvW3xKfr4374iCXhKWPdJ0GtyZiqHP07XdbrZtC2K82lSVjEMfAVEMMvuwLFRQXFPfH0oVYfZy/xorMy5n9NNELuvKKAb4HOKqrr0rEWwHNwlByX8jtuxU+mZE1ZSSlzx+xQJ0WWMLtyhXqbJkYhCU3+bRnHfYdvD3srKwV7MIUr4fdo9RfUTLJN5RHXi4e7wp5KcaqieqYS+zjJz1RNo/8UjtcuP/HKFlAWonE5CfaqUh4KufKBzQR89EVQhmrSxL9KP53nNipb+2YJGuHR80rFBZGTEmq9IZAjKjEvjwvxnjyUzvjX24XNeTgWP15MBv1emLtuRsv5BPGAeY7+XV49TidQGx/DkoAMEnnUNbzABl1mSZQIRP1HpEgEdD9DY/0XXFxLNV9AHV2Usp65H48tdifSIv63Hm+7XnW7V++P1++WIJ7tYwmHJhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bMWBTtbPdXfunKiAJVS41fwCjf5355AkCFxujpqvmKruuPV7BZOrmQmGN4fM?=
 =?us-ascii?Q?jLxXTHRnOB0m3jOoeoSnrngkX317V6BmLBbHm7TRR/4I5ucSaurhXihlMJNf?=
 =?us-ascii?Q?wkNMKte11vlClY+XI8jmj6wolEmiE7WFhtpLyfGxv85kccQ4VWcDbSc0kYIl?=
 =?us-ascii?Q?a+GlE/lnpgn5SO51Le7u3GLrr+GZ+5NjVIRckCbTZB7XHlLWXvOMVYlDmusK?=
 =?us-ascii?Q?K6pqlwsmJYWapWkewlv+OgxXfCnCD/GsX0lqgSa7hjdFtLdm82Xbc+W9DaDq?=
 =?us-ascii?Q?fePSBOwAJlrdxenLIcBDRzPoc4rDaYMkcH9oeRFGdb9hK2kZy4XgMZVvqlF2?=
 =?us-ascii?Q?FsnE7DTze6lAdetqEo8W5jHlE52buxWWKuIfAd4xuv/L0aBsuCD+FGmEu7y6?=
 =?us-ascii?Q?ZVnh+Tb9NsZj8yxBx5EDBK05sej8X0qvQzZbV/In5Arzp/oRcBXsc4d4EY7S?=
 =?us-ascii?Q?O6/ZhmknOzaEovpYLMVSR9Fn/eCBcU/nEe5dEz4ycG75ScmxrpfrLUna6TG8?=
 =?us-ascii?Q?RaLo2RgVIziQzRVvGPG2KhzWGfXjRWDgS3D06esgdQQ6JkDQMnVA5OWIGbgg?=
 =?us-ascii?Q?cGX12spu/Ko5nvqApx4E2jUf1H89MrgiVTuFIWVxx9hNmxOwqhx188M1jjw2?=
 =?us-ascii?Q?cvH7W+Ck2hgpVFjDzJsQ2FRcNb1h/h5T+7BCJYERP6ZgS3agUb/fq4BabYVY?=
 =?us-ascii?Q?avcrWk329RYVWHET/r5qY4FEoaYuK5r0Pb6lP0Y4exrxfRfKHrxdYDBWP4ES?=
 =?us-ascii?Q?yg8WM/RAyAnMuCrdW2EKPMlofYH+VthG4IUUhFI4BhCnm9RV7ZUiBr3M5Vvl?=
 =?us-ascii?Q?b7BkVttpxZly6bEbfr/BdB3fH+5WJsn5jybREQ3nUxFt0xp2MmSoIMSO7wdn?=
 =?us-ascii?Q?/ITL9xyo7r9pA7KRyEyN1B2QMIc1huyH7ltwCAy6r8WdnkIkUikZpjTzHa59?=
 =?us-ascii?Q?jEp7Ud8Ky6Q8r7uJTUQdZZd/kipilsSKrjjnW2lYKXa7jKWgQJT6fSTJzcSy?=
 =?us-ascii?Q?9/A6TXpcy53RKtAbWgkrhcpQ1Xx6HoS+nE9o0jviLI35lKfvbzYFZGg3fG6L?=
 =?us-ascii?Q?A3sVwrCW8HbLHRzJoKsuv4tdwRuLZ7GQ4KgSxWpGi1oBdRuLIcgAQ1KtBj85?=
 =?us-ascii?Q?H8qCDJQeYl+Q6+PORR6ukVKX1VLbwDqEH3c+36bcHRfT/4EWTmjcHn/jUdAM?=
 =?us-ascii?Q?3rtZJUCedeDJY1YBdTa36WfPW0pu1xTmHEjKi7rRHwaUw/sNL99gl3iqy3ss?=
 =?us-ascii?Q?55VjpV/LuWxFxhRUHsUhk9Ywx7qT96EvQeOZa6WnNVR34dycmFRWoUKvAzUl?=
 =?us-ascii?Q?Oyt4gHmqlr/QcXNGuPUSLpO+SE2yQ9PmYBOq92xbT3iBpmqcQoc0qteE5P94?=
 =?us-ascii?Q?zsbIgrzuIKNQpQ18iizL18gUjBpYZoG+bkP7H9OsVfGQ9cvBlEYiYFFidVd0?=
 =?us-ascii?Q?eHSAXO2hGui/Oo/JtwIBZLri8mJuxaza3pUU9o1qgvJa1CKestTH5FgIMvyV?=
 =?us-ascii?Q?WBlJWyMZ+/n1yZIhUMYGsQS7rk61b8XXZBDbSDBBGsyQbcYKSVkNDqQTjv6g?=
 =?us-ascii?Q?7KLJ2+/BapUy/9XEPb0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e6976-af4b-45b5-bb3d-08dc1911d712
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:39.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrblkYMrg2u47cl0LcYfHnnisRlSLQGHb96380X4ovFEkXxiDeD+pY3QR7SfYWyO8tdJjZNqUbLRSmzuPl2aFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Added rob's review tag
    Change from v7 to v8
    -none
    Change from v6 to v7
    - Added my sign off
    
    Change from v5 to v6
    - move atu and app after config
    
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a284a27c5e873..1b63089ff0aee 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -207,6 +207,7 @@ allOf:
                 - fsl,imx6sx-pcie
                 - fsl,imx6q-pcie
                 - fsl,imx6qp-pcie
+                - fsl,imx95-pcie
                 - fsl,imx6sx-pcie-ep
                 - fsl,imx6q-pcie-ep
                 - fsl,imx6qp-pcie-ep
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index eeca6b7b540f9..8b8d77b1154b5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -100,6 +101,23 @@ allOf:
             - const: dbi
             - const: config
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+            - const: atu
+            - const: app
+
   - if:
       properties:
         compatible:
@@ -121,6 +139,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


