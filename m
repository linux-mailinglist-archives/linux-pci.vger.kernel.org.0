Return-Path: <linux-pci+bounces-13301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195D397CF11
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC36284301
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468911B2EE1;
	Thu, 19 Sep 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LfFbEU2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659711B2EDB;
	Thu, 19 Sep 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783438; cv=fail; b=TWukvBlax38sfKdoc4VLNfRPg9bZeu0JORFkOn0YD4G5n2LaiyPJebYYDDcM6I+gH9DGPG4geFqPa0Zv14HB0Hz2eNhHEAxacts5858FxUwOOvJTRxJQCR8deBe/LQ9R4iaVLQCaazfGm+QVDfyLaa2HoTa/Srb5QQP0C4u0NUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783438; c=relaxed/simple;
	bh=CFoCwtRrggdpXdLt3i1OWIyXKTciqGwjpH4Uvpg1/bU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tqUAHHfqzpaxL5F4iz3PKID5iZH5mKDeT6lzJepyoEjzBseG+r0WpY2Vc2Pi1fEzt5Dhhyp/GQyn6fb2F9yxs0ID8+v1Xo4vV+kCvEBtHMWbnBWWYzMO1M1SsyRbOp4xskCDI2Wv/MezEg7Xki5LpI5uNjfgV1h3o9X724SNmiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LfFbEU2/; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXjTwSGivWoWgoczGf+CIhF/Ot9016YJh/UFE32kEocEy4DNnubv7TxEjXXH+/z0yaTAVb1K3DO5KU6s0x2P5OH339VVttQZ4AkUYv0u9EhkfhhC6tOBs4cdaMNBoqT8G4hfl8CE4pfIutn129vWsi8G5T9HhYG3e0usr8RCTGSttrQtP58uvpTgM6aS0W0GF01ubNFtlo/Y1OzZmR/aRKzE41/jsTBDalUVh4GD+yU02s8CXx8dCtjaVwyt4RN0zqkGMuva2j0YRiFzOhHnwpVi6/c0j8b5Hivh0IBm2aLvY4ZzINs0vsl5gvuIk0KN1N/4dudPl9CbH8fsGihahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOhge9LSN+/6iSc55XWDZwS8m6rfwMYknlDwdks4E/U=;
 b=i/cseLLCqeV/iBugVet8rqY7sz6CiZtUSK2WQ09rNvGUFlOMCwQQVR3sJbN8iM1foCDqGGW4kX+X8uC80Nwg3RbJqUeg0tWzLDSHBav/C5x0W679XMyGB5YHv914iVivuW38JstT8RQ1gnjnKNErCGNLiGFG0P6JqW4GwLFcSTjRkh99IMXC/hK5SIT7d69Ui3eTNcOczzRTaT8S/++KaoHNNAncJQM6Oy29qWFDdOdjnVNQKP55iwd9AVQaZdt/L9p6VFhN8mty/xGf3979Zv65F2bDlPYk2F1emVEFTpI1AiM3iOsLV4kEWKFBCfG/22AR6nqOTiYzJ4i9ZybQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOhge9LSN+/6iSc55XWDZwS8m6rfwMYknlDwdks4E/U=;
 b=LfFbEU2/yKzI8qAvw5ik15kwOjNFpA88vmGXmGDQUKuyMRj/SSYYNFGztH0nVGjrTE4fCsVAumx8jy70h8RjRG17GftVftsRpdZQ79qvypevQR0Orycl0jNS94WbGBSJRTROcTdBvHtLJ6wm8peuHLAjgVyLhiUp141vay7rkNgvvr6XfKhK4iM/CJRaillS7cVVldEWavsINVi/YIor4GoyLpsAT7F2d5dVDUI9lMrp7ngH9UfLbh1pfULaosPzKj0v9z9g1ZF+DjpPQCvv50ttZrXrFNKgSaespjT423czMUJyfcH6XlIfHkB//Qw6sUiLpmwSL7zxUPHpS9WjVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:03:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:03:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:02 -0400
Subject: [PATCH 2/9] of: address: Add argument 'name' for of_node_is_pcie()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-2-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=1162;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CFoCwtRrggdpXdLt3i1OWIyXKTciqGwjpH4Uvpg1/bU=;
 b=tXUs2v0V0RFIwa6ZPvWr3y0CX4s/taaNmgg+vmk8xP6+YDS9rxHO9lCenfMS05RisYBvIp7X8
 8WfX4Fzn2jWDiQ5EKMND3xZQ71drhyNVM622z+VGhuMDF5e/BXt4dEV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ba111b-2363-468b-a15e-08dcd8f6ef9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2xUeHlVbHZUK3l1ckI4aTZkZGg0MGtlS1hzcDhzbWJTME8vclpMNXcvSDh2?=
 =?utf-8?B?VTd5MXpNc2RzWkVuVTNDUG9sWDcvd1lLSUFxaVNLbXpVeENYZXRBc0pldHI1?=
 =?utf-8?B?cUZhbEVFNis1NjhvNUxtVTg4OWFGOVYzU1RoMzEzeGE3cFZOOTlVaTBubFRV?=
 =?utf-8?B?Zmh4RDZlNklZUkc2a08vMnZIMG9HbTZwUnBDdEJjQndZRjNDMGlSdmo0ZURk?=
 =?utf-8?B?R2JaMXh0YlBFTEprL1ZHYWd1ZFJZRTdINHpPMFFOSmFpaGdpaVpFYysrdW1V?=
 =?utf-8?B?NnRLSlNGaExLZkdZbG1DRTk2aXhLQUZOeS80SjU1UFRqRkRQRWxwZDVMNzVM?=
 =?utf-8?B?VDM3UkFTL0g5ZjE3ZmE3LzlqOUZlL2dGbzc3ZU1RZmN3NkNYOHNZUmpSSFll?=
 =?utf-8?B?dlNhZ05MZFY4RFljV3VVMyt6eTk3UWhoampYL1AvQU96bjF2SDdvdUF5d254?=
 =?utf-8?B?RVdSSFEzU0tJejM5WnZmaUV4NmNrRXk4eDJBWjd3WU8ySGRaMjRtM0F0MmU4?=
 =?utf-8?B?b2lCSU5WNDJWeWVvNzk1d2U2R1NiSHBxakxGdkJXUytLODQwMkQ4Y0FkRGYv?=
 =?utf-8?B?V0NLMWxPWm4zK1NVRWVkRTZkRkxWai9xQUNnTjhqMSs3aWhTT2hYSEdmeUNz?=
 =?utf-8?B?VUZSR3ZtS1hKYmlvT092NmVpcHhJSnRkdjBVU2t2dXNUN1ZBWFNBQm1BMWJF?=
 =?utf-8?B?NEJTdzExMGdjQWhjMFZlRlMwa1NobkR4Z1d4cUJjMkd5eFNFTENXb1YwQVhB?=
 =?utf-8?B?bWlmVjZrRjZwbW9mYWFBQU4zZEJyMVp1L2pvNHVRMzI2Z0JMSkZ3V1cxZkxZ?=
 =?utf-8?B?VGNqSGt3T3Z1YUxoNlo1RCszaitobFBxR25CNVFxMlRHTXBMQXlyWEdpZ2Jn?=
 =?utf-8?B?cGdNT0dHRzU1RE9UQW9jQ0J3am0wUlRNa2R3QTZLUzRYL2FiSlhCRWx4VWpO?=
 =?utf-8?B?Y3VSbEtVcVlTTHNkNjR4L2gvTTM5d2MzbHVtUi9zZldPcG8zNmsxMDlIS3A2?=
 =?utf-8?B?aXdKcDZRRFFZaWtqcTZWTFRzeUNhaWxxYW5kd2thUGlEZDlvaXY2UXkzN0Zo?=
 =?utf-8?B?bWtJWHVNTUV4azIrM2RHSHZPYmlaaDFDYUlnOGVuU1g2UlU5ekoyUWp4Mmkr?=
 =?utf-8?B?Y3laUzlLNnU3bkVaem1PdHVUS1YvRk9SZUJPM2ZLR3FzUXhHRmNrL1VMT0RG?=
 =?utf-8?B?Qk4xZlVpRkY2WGs0REFJd1JvUDZnVkQ4V3JPVXlyOFQxTnRYUGN3MThIejhl?=
 =?utf-8?B?ejdVRkpaZTREd3k5THZneDB3OXpERnlESjArck9BNUp1QzQzU1lFZjQvM3JS?=
 =?utf-8?B?N2FKaEczRVFBR0I3VkpQUlQ2dG9YeHVGOWR5ZjM3dkdWNkFPZFBvZlNUckJ4?=
 =?utf-8?B?bG9wUDV0MHFDb2IyenZvaEczTzJPUEo4U0RMZEEvZE1QT1RUaTVmSlpHVUo5?=
 =?utf-8?B?YW5WaEU4bnY0QlIreHBaUmV2VVdBalZOQlFFYTJBZ1Z5WFRTRUhpQlBONWk5?=
 =?utf-8?B?NDRXZUpKcks2NHNhS1JPMWZPL2tsUnp6aHQ4aS9KdkpDa0JWR3FHeFF6OExy?=
 =?utf-8?B?T0VHd0ZDU091K2I4K1dVVityZnZnS1dTK0lnNnpJYjRuYk9PUTAzQ3B2RTVv?=
 =?utf-8?B?MzhzQ3EydW5mK3p0dlZuRnd2Z29pd1FjZ3QyTCtFU1Z2SzdoazExaTNJRW1P?=
 =?utf-8?B?SUdFdFJkUmQwUHJtME44SHM2SlZTblJIaXFRT3lIVTNTK0h6T3JWUGpuZ3Rt?=
 =?utf-8?B?RTdvRmwxaGtOOVpNMithMVR0SGIyVkszN090UFlXSnNNc1BwRWlZNGVYakgx?=
 =?utf-8?B?Y3owTmtBc20rN0JGZmxVc2hiT1RKSkVyMllHMHM3SUpUck5UandYaFhWVTBr?=
 =?utf-8?B?SHk4elRRYmFyVGpqSmw4U0hpRWZ4QXB1K0JqYlRTQS9MdmVMWUtGRnJVcU1l?=
 =?utf-8?Q?SB+zgHRrx7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnlDcmhhb1B2cnN0eS9SQ2pnWEdaZzFDR1ZkRjFaSTB2K2NobU1ZeXhzemx3?=
 =?utf-8?B?KzVMR0t2Vkh1WEIvWEtmL05JSnZvZjcraitBOTZyYk1aT2E3OHlaWk9iWHRY?=
 =?utf-8?B?S1JsT3IwaWZsNUVaTTNzcE9lQUtaN2FaZVpXcDQyWFZGRXU4ejVMa3lMSW1W?=
 =?utf-8?B?SUlQL0k2VWZ3SGJxZ1NjeG8rKzVUd2xwcGJjNEdFY1MySmxhczIvdU5tc25E?=
 =?utf-8?B?WG92cDFUNk1URFpvS0lBYi9YdHhOMmN3eWNPZ2F4NHVEV3ZRVU9rV05DSzRK?=
 =?utf-8?B?cTVHZEtCakFwcjE3YUtrdXBqazVnakIraWhQUWVRcW1XQTJXVzUyWk83VVlE?=
 =?utf-8?B?aEIyMVUvdUwwVWg1d1crWHB1OEIrc2doSFlkZWdXMVNVWVlPMXBSVW5jcWdw?=
 =?utf-8?B?N0FMaUN1ZUFEWE5DUnpLTW1hbXZ5RFdQS0RTZ3dqdzY3TldVbDFjZWtZQmI4?=
 =?utf-8?B?OWFNMGlVMUF1S2ZranhnV3RqTlIxM0tkZUJndUt3SXBVQ0JlWThKMjB4QXZX?=
 =?utf-8?B?ZG1obkwxUm03dDhuLzVBS0lTeFRoZ041SmowNjhwZHhibyswVCtqNFIycTdQ?=
 =?utf-8?B?eU5IKzlDV1J2QUlBNjBpd2hwN0FkMTJ1bnpWdDRrVHNOL0c4eUVyeU92SmRW?=
 =?utf-8?B?NUhCZmZxTExSaEVOTXQ3Kzl3dlFLaG82OGg0clEvOXlEcitRNnpBRFZDRnBj?=
 =?utf-8?B?SE43ZjVta091dHYvemsyZ3FqUW04NDU3SmNnVXYrSHFDTzRacTZMVEdBbU5F?=
 =?utf-8?B?MWl2SmZXOHVod0lwTTRzTklZT3BpNzRhVDZRK1l0TExDa2pBM09YcTByWnlx?=
 =?utf-8?B?RTJuZUNJdFRiNWp4NWtMZWFhZ3REZGN6elU3T3dvSk8xdzg5ZDRNcUdtTFhk?=
 =?utf-8?B?czNGRUVKWmpRSzJNKzkzSWFHSkNxY0dZYnVGek9uYXZFUTVpS2c4L2dlNHRM?=
 =?utf-8?B?WnorM3FETE4zd1U2TlVHZExabEh4KzFvQlZudWFTRERhV2xvTm1tdVVXOGll?=
 =?utf-8?B?S01Od203OHYxNVY1cVdDUFNyRzcrRXF4bkhNZW1qeTVpRXM0YWh2ODZBTHNZ?=
 =?utf-8?B?dXYyK1lUZkpROWpZZ2VwTUpSdWpKajVkVnFBbUlHcUlFQm02QU9LN2QrSTBz?=
 =?utf-8?B?QloraDNSdHViQkptcTVDNXI1Uzg5TndYemxKYmZ2RExDd3NTZDg0cGl0d1kv?=
 =?utf-8?B?ei9vaHk3b0IwMXpDMVZOWkE4ajNuWWZzQ3U4UWdzcUF3WXRnRm5jUUNSTjg1?=
 =?utf-8?B?T2ZYNG53NGhoelpQOVdlRGZER0J3RVlWNFhmUjIrQVdLbkpBbmVxVmNwRTNS?=
 =?utf-8?B?OVNsSDhQK3E5ZGNQR3pXLzdHM2dqOTByZUlqMEhDdGdBSURIdmtvR1FzamRT?=
 =?utf-8?B?WXI4QUh6aStVYkpFaFV0R1R0dFR2K3BLSk04d3NqbEZZbENlNmlHMVIxTmdo?=
 =?utf-8?B?VjY4NTl5dkNNaytXRFdkeDhib00rV09BencxeThuZ2wveVhPeEtLQ2hQY3ls?=
 =?utf-8?B?dVRHSWFJaDFzUnlyMWZvam12ejNhcFdwK1hwTWxsbWJnSThhQ2xpd043NWJX?=
 =?utf-8?B?TlZsTEEwMU0xWWN3K205TDVaTzRBUkYranc2czkybmhNVzZ3SHd1OHVmLzJa?=
 =?utf-8?B?QXc2MXFMb2lYRUZTMDJ2VGVPeXFHWkVyWnlYUEw1eEdySkFLL1VXbWhkQUV4?=
 =?utf-8?B?TFR6T1huRGVpNllOY3V6WWNmQ3VaUGRaNDlsWjk1VjhPME0xZmZVSldBRUZQ?=
 =?utf-8?B?S2hlbDBVV1lDK2l5bkJicUovN0JhSWdvY1NURlZXMHI3SmY5SzVuTTY4TmFE?=
 =?utf-8?B?K0lRNGJXWmlNd3FBdXhVemlLRTM2Q0ZVaWxMNTY5WCt5TVJrWURlcFZwdnpa?=
 =?utf-8?B?NG55WmNhQVJndnVqa2ZmYS8zbnhyUWplYTkvR05Pb3h5ZS9xUUcrS0NTVmtK?=
 =?utf-8?B?T2JRT0hZVE82b04wQXlTRXZ6MEgwUVRiWjJDZDlrOW5lVUxKWW1zMGVWWWNv?=
 =?utf-8?B?dlpsRXBuREtFZDhDQXZQRTVLajJPM1o0ekxVQnMyK2lXTHMyOGxEUXREVFVo?=
 =?utf-8?B?U2RPNnN3ZHcyT2VtS1o1dHM4cEpvM3YrRzhRWUE0a3FJS2ZZOGxCTElxQnhj?=
 =?utf-8?Q?UK1SHembfB19GygU+KcGSX2NM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba111b-2363-468b-a15e-08dcd8f6ef9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:03:47.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei2qlU0msnF5nG6lG9DZ8S2CefiMJwYTQFe0/ONIl7Gxl/ur7eYJZrPhir5NzBLfaHczDM/xYwHeZLWYxAdIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Add argument 'name' for help function of_node_is_pcie(). Prepare for adding
pci-ep support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/of/address.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e332..d886f16df8a6e 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -147,9 +147,9 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
  * PCI bus specific translator
  */
 
-static bool of_node_is_pcie(struct device_node *np)
+static bool of_node_is_pcie(struct device_node *np, const char *name)
 {
-	bool is_pcie = of_node_name_eq(np, "pcie");
+	bool is_pcie = of_node_name_eq(np, name);
 
 	if (is_pcie)
 		pr_warn_once("%pOF: Missing device_type\n", np);
@@ -169,7 +169,7 @@ static int of_bus_pci_match(struct device_node *np)
 	 */
 	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
 		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
-		of_node_is_pcie(np);
+		of_node_is_pcie(np, "pcie");
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,

-- 
2.34.1


