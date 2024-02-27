Return-Path: <linux-pci+bounces-4152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CE86A090
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DA1F2193E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A0149E1D;
	Tue, 27 Feb 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiQUs9IL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFA149E13
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063630; cv=fail; b=PaCqMM1B+YI0913btnQt772nYJ863B0un5PXiIM3CxEKGfwAEM8Maws4YoER6yRa6rs5jXdI2L3BuqYkW3otOOtJvQ0Nn19XVpf80MY+hPf9VdQ/iZV/QjTnNkAmEOLevi+Rm/hvVPzd2vT8lzoHiVBPc6VjnhC5FoHD5XsK/dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063630; c=relaxed/simple;
	bh=4jIUCQexiU64zLWWTkbYwelazNpNinAxl8dQQKNXyHM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx4qy/udGlcC+ZH4FRocXJB3Rc/KD4TCsIfcZ+T4E+8oc1WfNyKK3dsGaAvFDJVbI/fkSb1g8gvLxo0SFTY2fUE8VfWiiDmcJt80BLunx54KZnCxSStUZJOxK7iXbJSbhxYdPzdWMBFjiJ7rQZuMdICVB2HCW7XMd5lEIsAxTNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uiQUs9IL; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUbS4l6nrdzH92VuzXWz5nuUvUji4d8bUB3wIuIKHToO3C5hFOim30QLRch14F87wJGz2WcBv0Ba+5nj6p1YmitLbEER1uGy0uNJYRYeAgY7iaWYpyBPgZ9fbE7C7xFO8Y96FQkfgaoEwrwa+ZRD6LrsVRcCfiTWcbQEF40kAnfICYRqoVwkN4k0ATTuc7N4mMfFZcuXvZFWW93FwvOkWTYwWrtl21NA+THj/ULDqDmJEBXmB7r7fcCnbJUR+RfNlB/xHnWmlo9l2kxQ77LLHs6T5RSJcxJEy6tv5OgsnU3tjnwPps8W0vJ4acVdqbuLe8H0lyAnX867Uj1oxn3FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0BhK26vu7YbhX7MyJ9OslCgO0qD5qzzPGTwVuFkgwY=;
 b=oGu7g9TfzvIDTFcB/0pY/LjUeFZzVUt9WKa5er6oMq9eNldFz6xwOEaTQSs+ywmN26nh4gHEKytHPydsWWXV30dAjMhbCO97EE8nOnDRgFyNXurpMTlqi/EvMQsiyYGuk9x9P5h3sQeXDalKu6MDN4DmobsWvEKbU2C3hYbP3BcGtn5tge9UpDBHsZselAw4Frz3rxlgRNjYvZuTTCd8HOcPTh4EnRpu6Afad851ytJxWWLuvXS67G20NcIQRGaar8VMdIbFlPHPJEJ3GAjKQsXeTOaeAO5jjyV8yW2zLN7BDTd4Tf3csyyNFgZiEPHY2OmKbqmuA+MYs5Mrs0DqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0BhK26vu7YbhX7MyJ9OslCgO0qD5qzzPGTwVuFkgwY=;
 b=uiQUs9ILH13/U+eq+ZLaQ4IWrdmTolaMqNqp+Fwh9C6GOr8kZ53eLaGW+0GvfeOxPE5hgf4tKlg5l3+3g15I7lHRGhUoQs7Wit5YrEpR/XF/n3CWmQpAGuLBCUpt4YgzGXS/h2zhqFy6WKcdOf042MRJeyzMcGkwWYcwgf01nkFq4GIf+Puol/cXE0O/NcDMsHA3a7bfmv7hJmSQXGrgzv5V+Ipdh/xHvWtEn+4zWwC28RE3K7CY/65aKEeOpZH0AKFHw+eePs/A9MCm+AC/G9cHdsiqzy1CuozI7z3Qs6Ubgtejlui8xUTnGtUtw8HZ5j/f1GyYAg3/P+Cn3nYIvg==
Received: from BYAPR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:40::27)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 19:53:42 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::26) by BYAPR04CA0014.outlook.office365.com
 (2603:10b6:a03:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 19:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 19:53:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 11:53:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 11:53:25 -0800
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 27 Feb
 2024 11:53:22 -0800
Date: Tue, 27 Feb 2024 21:53:22 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <zhiwang@kernel.org>, <gdhanuskodi@nvidia.com>,
	<cjia@nvidia.com>, <acurrid@nvidia.com>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20240227215322.00001f46.zhiw@nvidia.com>
In-Reply-To: <65dd828e928d5_1138c7294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
	<170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
	<20240226133708.00005e8e.zhiw@nvidia.com>
	<65dd828e928d5_1138c7294b2@dwillia2-xfh.jf.intel.com.notmuch>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b23e4d0-440d-4ca8-7b82-08dc37cdcc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cD1R4t3dj9u60cUJAjLQcW3ZzKL8Wv+aKThy1TwJN4MFAfv1h3ckWtFP1FhRjBQc5vkGnR7IOqoc2xnghGO+azep0Cfowgk6TG+UeVbjcZGr97N7rZKIskRtr3gjLYk6apA2+0kwrghbv25CQgNBbNzU9BlkYBymGvDyewojnR285nsM62n8fB6sY1HmmO+sd8mgL0BL7Gvbe1OuajflTEsquuXrL36v75woJPdSIqzycEWQ5nI9D/xb++gb9xLEJHpfgvTa3rLmI7BuCDauI9TyiV/umT+GQfisDVZIAuc8lEzfwr4NIrlIjEVZJ7VrDbRRQRcib3RyQQz1uwHIoQTaB2thnEZuEK4xJiI7ucTlW1EbNMC2kC3uMi3ymi+KVAQMUltx8jAEOi3jWLk5CQMr+iwAnd0e27PETg61b0SXaJmq2xWhXEiF/HlpC+ERBBrPGp+6dkFBI9NRjOPRZWbYGht2JwbkfPbaCwuqUZJByAiGTiEC08h1hH4BIjNDbXiXxMIcMjiVtw0IW28OBvCAKBWJR4ifvS87Qiqd9ZRe6F3ysdRLjf/wudSKcy+q+YnhnMOvwiK4Ia07yWKwfF1+cwLgVVOaBoNluQUhAjfe0QlRfmn00yqXTQXOmkEWPXMaWfsWD6CD2c/39nwplA3Zj/fq1ccnipbc/Z71alD+sATU/EP0im3BAkTrA0ElUt7PpSVJ8v+GMclDmMxh1z2tBEUmKq1g2spZj/pvpHUzpntMBJsyPKkRPolOc9Yj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:53:41.8351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b23e4d0-440d-4ca8-7b82-08dc37cdcc97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On Mon, 26 Feb 2024 22:34:54 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Zhi Wang wrote:
> [..]
> > Hey Dan,
> > 
> > 1) What is the expectation of using the device connect and
> > disconnect in the guest-driven secure I/O enlightenment?
> 
> "Connect" is state of the link that can be automatically maintained
> over events like reset and error recovery. The guest is responsible
> for Bind / Unbind.
> 
> Now, the host can optionally "Connect" in response to a "Bind" event,
> but it is not clear that such a mechanism is needed. It likely is
> going to depend on how error handling is implemented, and whether an
> event that causes disconnect can be recovered. We may get there, but
> likely not in the initial phases of the implementation.
> 
> > In the last device security meeting, you said the sysfs interface
> > was mostly for higher level software stacks, like virt-manager. I
> > was wondering what would be the picture looks like when coping these
> > statement with the guest-driven model. Are we expecting the device
> > connect triggered by QEMU when extracting the guest request from the
> > secure channel in this case?
> 
> I think it is simplest for now if "Connect" is a pre-requisite for
> guest-triggered "Bind".
>

Thanks so much for the reply. 

IIUC, it means a guest assumes the device is in "connect" state when
noticing a TDI, and it has the awareness that the "connect" state will
be taken care by host until it needs to step in error recovery?

I am more thinking of how device driver talks with the PCI core.

+static int pci_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_tsm_req *req __free(req_free) = NULL;
+
+	/* opportunistic state checks to skip allocating a request */
+	if (pdev->tsm->state >= PCI_TSM_CONNECT)
+		return 0;
+

As this patch is triggered by userspace through sysfs, I am wondering
would it be a good idea to let the device driver step in around the
device connect/disconnect flow in the future? as a device might needs to
be switched to different states before it is ready to handle SPDM and
IDE.

Maybe the PCI core (pci_tsm_{connect, disconnect, error_handling}())
should broadcast the event through a notifier when checking the connect
state. An example kernel user of that notifier can forward the event to
the userspace as udev events via PF_NETLINK.

+	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_CONNECT);
+	if (!req)
+		return -ENOMEM;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
+		enum pci_tsm_op_status status;
+
+		/* revalidate state */
+		if (pdev->tsm->state >= PCI_TSM_CONNECT)
+			return 0;
+		if (pdev->tsm->state < PCI_TSM_INIT)
+			return -ENXIO;
+
+		do {
+			status = tsm_ops->exec(pdev, req);
+			req->seq++;
+		} while (status == PCI_TSM_SPDM_REQ);
+
+		if (status == PCI_TSM_FAIL)
+			return -EIO;
+		pdev->tsm->state = PCI_TSM_CONNECT;
+	}
+	return 0;
+}
 
> > 2) How does the device-specific logic fit into the new TSM
> > services? E.g. when the TDISP connect is triggered by userspace, a
> > device needs to perform quirks before/after/inside the verbs, or a
> > device needs an interface to tell TSM service when it is able to
> > response to some verbs. Do you think we needs to have a set of
> > callbacks from the device side for the PCI TSM service to call?
> 
> True "quirks" would be driven by bug reports. Outside of that likely

Yup, I was just thinking another approach for the device specific code
to step in for pci_tsm_{connect,disconnect}() without a driver and
pci-quirks just popped up. :)

> the attestation information needs to have multiple validation entry
> points for userspace, PCI core, and endpoint drivers to each have a
> chance to deploy some attestation policy. Some of these questions
> will need have common answers developed between the native CMA
> implementation and the TSM implementation since CMA needs to solve
> some of ABI issues of making measurements available to attestation
> agents.
> 
> At Plumbers I had been thinking "golden measurements" injected into
> the kernel ahead of interface validation gives the kernel the most
> autonomy, but questions about measurement nonce and other concerns
> tempered my thinking there. Plenty to still talk about and navigate.

Yes. We had been discussing that a lot. :) I also carefully watched the
playback of LPC Confidential MC, quite a lot nice discussions. Out
of curiosity, were folks think eBPF a good fit or an overkill here? :)

Thanks,
Zhi.

