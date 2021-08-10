Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918523E5E03
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhHJOb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 10:31:58 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:38517
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhHJOb5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 10:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYQGOlL9qVsJRbige2Ys3MHJGy7RaOdhmOvyRk/UnRTs0QjAcrZuID1sbmtpSMPP6tuThkhFql2SvFllBownSWl7kE9Cx6VwFdZYgR0jUpVYG1COOVu4e6LnM1qjJNJr+von6Hy5Qtusysu///xLHC0uWIy+aLlbCMDxztbBOzWwJq2Zk4MBMkMSELI9b9+aAn5EJDMjOKoJBMyex3DofxJSge2ryZfz8h2QARhrm6IPWtsxKWG3bfQIY17fxYUvAy+MpB9BrZkC2Npz1ylWxj5sNg+DjaMIRI5Xp+SsLcW7Undt0WlWebsEZtseqZCOnFNCjq+oChUVknny4LRVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFRVIGtqy6Pp+PwfBFzooKPpfsRFQsBOVOAH8BPYosw=;
 b=flwcGvjycuEFwKDOADB9difFjOYgUt3HYcqWma+pjP4kP8y2S8hYOd0M7P7YrILdlHxSHwnWRH/ZyYSab8yuFfDzWIb2djGust6z7lIPKII17WdKr0KcSxyOuFkHMPDucSyGqGJw9am4y7mIkOkbFXMnrjdgVtZh7SkgBabUjfU/Lp0+XuW3Bn9sUzJ0tgYHde0j8aqulLa9JUGTKo/bJWd0LctbGIR1TAJVU8rEC9Tx2m/br+aRu/gXYeRpHl3d2QrZXOzvQ61Fti7j6odfu80w9yKLzKyvYlWNGNt1i0w229uzyDoM3BRVuqA3AuYtvUdjp1vAVKwWua6mZBK6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFRVIGtqy6Pp+PwfBFzooKPpfsRFQsBOVOAH8BPYosw=;
 b=bt+B5+/roKCjFCMB99KgesZFtJqpBz1y4IR4iynVvype4/ZSNRMcxrYZ9FjbT9yyihlQtISqZDFpQrxcxuvq57X5HvMDA2KlIvWizLZcexaMn4s91kBx6y1nfR8F0hUmlgl00UGoofHGfvrEdcqconKgF3fqgUgpnjSfk/UQu6fB/6uK/jhTw0RVW1SQx5G9Vq0zfRyIUdIRQwUHsC7q8Q29k5Dc7naprJQweYe4wzx5YItHEs4xwUvuT88FikjGrc+Rm9eX74EchW6oAjytjgRYEQRZL/yP3WJKu3SA9OnOhuF3nyU2uXoH5OxzZl9fRWNomJpPGHiEfQHCkIBd2A==
Received: from BN9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:fa::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 14:31:34 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::1d) by BN9PR03CA0026.outlook.office365.com
 (2603:10b6:408:fa::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Tue, 10 Aug 2021 14:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 14:31:33 +0000
Received: from [10.20.114.145] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 14:31:32 +0000
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Jeremy Linton <jeremy.linton@arm.com>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <nsaenz@kernel.org>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-4-jeremy.linton@arm.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <b574f9bb-72f3-72cd-9a6a-f1f4d998afda@nvidia.com>
Date:   Tue, 10 Aug 2021 09:31:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805211200.491275-4-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce751c86-85d3-4899-c716-08d95c0b8daf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23668CCD03340F7D32601904C7F79@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUHTvJ0sklA4r/brSG9ywNGf9rDfY5D3XMCwjiAFEz572P05XD24mgRui9vXcnUppGwrBD0WXcZbh0faUdT8rospzFy0GxgDC+F8qD34bmyvR/NXtDJrvayPSELg5TB1/EWa7QAJoyetM/cuebTr6IySBdlJTjPm4F0JGm4EcDKKRK1bdiktpZ02Rkj0caEWfSnq+LBbJNTudXTjpKsK4dOMpi5Ps34WVWQRBpSJd9ab524wa+DCgmlyPp8YXKxVVQDeCGOu5bvMi+8B4qldCcsUq5qjgSzGdGUHUlnABVpz9YluOxEvwZX73feaHqBJSIjg1DOuY4F2sh42jrA+KkRjKI7yM7ZEU0GjBwsuDvgy1z2sPjDEA9swryXVpwxeBtzGaUbIcjykGas8/qRsOtap32uGbcue1rV/fYCt8dN6fHYpnQAeeYVw6ZNDGa2jEUAtWF/GKYsrylfjAt/Y8FAEZsP9O2qhFkI4Z60H3lBheSEz1j6JOvK6L4q77OqepOLxAbh0XZnRAfbNQC5YGTZXTFBW7myzXv894RHeRe/UR0NbtcwHZ7qB1VVSkjKFqFhsNDtvT9TuFYaqGxIeV6MDA2r8YsC1twIOvoiXa04lvRIA6Flw8YBZJzJ7OKEqKH646NsRXKEJ7aDDYt89K32jWsR3AzshswrHdpU7WpCyA/3Zd5L0gkdCNkWXyIKQB7d59Q7PBbJyxJOPQ3xIozSS3y/Q/cMqDOoIjF96ENQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(8676002)(70586007)(186003)(31696002)(36860700001)(70206006)(4326008)(2906002)(2616005)(31686004)(7636003)(47076005)(336012)(426003)(16526019)(8936002)(508600001)(83380400001)(110136005)(36756003)(16576012)(86362001)(54906003)(53546011)(26005)(5660300002)(36906005)(316002)(82310400003)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 14:31:33.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce751c86-85d3-4899-c716-08d95c0b8daf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jeremy,

On 8/5/21 4:12 PM, Jeremy Linton wrote:
> Now that we have a bcm2711 quirk, we need to be able to
> detect it when the MCFG is missing. Use a namespace
> property as an alternative to the MCFG OEM.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..7d77fc72c2a4 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>         ALTRA_ECAM_QUIRK(1, 13),
>         ALTRA_ECAM_QUIRK(1, 14),
>         ALTRA_ECAM_QUIRK(1, 15),
> +
> +       { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> +         DEFINE_RES_MEM(0xFD500000, 0xA000) },
>  };
>
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>         u16 segment = root->segment;
>         struct resource *bus_range = &root->secondary;
>         struct mcfg_fixup *f;
> +       const char *soc;
>         int i;
>
> +       /*
> +        * This could be a machine with a PCI/SMC conduit,
> +        * which means it doens't have MCFG. Get the machineid from
> +        * the namespace definition instead.
> +        */
> +       if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
> +                                        "linux,pcie-quirk", &soc)) {
> +               memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
> +       }
> +

Is there any specific reason for not using the firmware agnostic API to get properties?
 

 if (!device_property_read_string(root->device, "linux,pcie-quirk", &soc)) {
     memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
 }


