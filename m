Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4636C810
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhD0Ozv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 10:55:51 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:27361
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236144AbhD0Ozu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 10:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxE6wy+s2QBbajI3Y+u0Fi0UI11PYXc6oPHBOTKtEHpgJwhDmxTPU1JYIRh5TM+zqsWwr7eou/ULrpTz6VL+hSopY0DjuYemHfTNDseQi/sV5c3QBi3++seNrn1IvbEnfZcLoIrrmqGy2ZJ8LiN2m0NBE5ysp0o9D1aoDRc9pc/HeN1VvyHZR75iSSUGD7A2IknC7rtvwd7N3pDQr3qzUCn8ifL/Ur0naA2AFc6tzRgNTQW1uRQuAWMjMH4IR/ldJP1Dp2Urcyp8Ne8Ek9MRw3v3KWimpLJiCEGPduHBwPKARlDY98W7di5WsS1TRxAM8g5EnB68ZW5WiNIyceRRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gSWfNWx6o2Nsy43Jh+oVhKz85/9gJzAmAM+rNhel/U=;
 b=MIjjRyroOSUSVbzQFpC6AjzRpgJRrm37orE3i5q8Gdv77HjwS3qPNfbZ0zNVw1nRLcoiiu5MDju8XfnE/J9wWi8uqWpW57u8qNVd7qJVCb0rbe0rFKe/6uwshtUFeAruauQ11Ootgxx9V8eEhmXOyfcdN/J7OhnBRyEOr8ibDw4WzXp6MguP0gWSizc7VG2poTN7731w6G2Jnm49h5up0SZe4a3uMucJkYIAwaw0tMb8LKI7IOhCHjP5l1swDrtxoE9dsO90SZXaTtvwg0/9dHfE8Jv7ujtkhukrDWYvVUBpnWgAuWdaSuIT78RrU/fSG5ALkwCLRupwMy0W73u7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gSWfNWx6o2Nsy43Jh+oVhKz85/9gJzAmAM+rNhel/U=;
 b=Y5bJdAa03Mtsp7BAi+PJ8O4Xubk7trzj34U2POTiB+4PKQpP1NXpj8Pn7OWxaxK7SMTaWCgK7rxG8u0HGuoz5gCjS/65vqQjOuINjmhMXH1iSLgZWwze1gTKiuIzYL/bHPDLuvbZvOLaXsuZ67tHbTLxFhLDGgwqtDgF12RUdIDv8VHTELL4m5h37GMTMInEvzMEcJrzpuosB2uU1vls05SffedqQ8ycyMGpXRLpE5y9PxJkJxH6wVTptjkzLWId4DWxVUd5NGamSbUt05Mz8CJT34HWH+mKV89FFwX6knPrPS5kzY/8w+QtHB5QlMe2fOGWenXraxHb1to+91JW/w==
Received: from MW4PR03CA0056.namprd03.prod.outlook.com (2603:10b6:303:8e::31)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 14:55:05 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::79) by MW4PR03CA0056.outlook.office365.com
 (2603:10b6:303:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Tue, 27 Apr 2021 14:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 14:55:05 +0000
Received: from [10.20.22.163] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Apr
 2021 14:55:04 +0000
Subject: Re: [PATCH v2 1/2] PCI: Add support for a functional level reset
 based on _RST method
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>
References: <20210427022802.21458-1-sdonthineni@nvidia.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <1cc3cad6-c100-5fe7-6fa2-664108c985e2@nvidia.com>
Date:   Tue, 27 Apr 2021 09:55:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427022802.21458-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588d630e-3826-4d3e-77f9-08d9098c719d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4316:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4316C034839D8B3864D1BCACC7419@DM6PR12MB4316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C94GSWNUDFSX/rFgfe0ssyl9mSc/eXMK6IuQ+Ov3OLhoEBJnDwW4tr/DoXF02eIsXWqIaSIBeFC21FTjKbpDuAvYcWXG4OgC0MhGosDPbSizIV+A0siMc77P9Y48bG5nJsalCaxi/u85TGXJPXYzYnzN9VG58XgV8uwrHBwBgYPTaZ2jRdoOTbcyIqWEDTKBMKokt33MJUzvmq7yaHy4o0R6f2zLqfjkoVME30UM9k+wV9N7OBWcXaLpt3ohILuhUmIfx/DHdrqRVUW8vmw1E6nvS6DNLyZSDPswRQnsXcL7u+RiveHaKVccFHVXcNhT0qHaltRf97etJ+QXR/q71kRdbi5x/m43NMLS9Rs4G6LDAYkq1gEkbUwr9QltdL4rpICEgNrC/SZsxckVtH29bVwWN8RzYgdaDuwaGA687X9B+oaf2LLl3fajRcs08nk4OxLbzBIcnwC+n0xDptJ1fVIntv9qWZ/UwI3pkBL0iSm6EgbsuLj+P5znpK+6zDJmkdiFEtBEKQq30wdkfD5RVT13CJGoIWhgLR2pFAR9PBDXF3X3tGk9c9ewUh8WTShj/2UF9r19KjO8fdt7fK9FUSkY3FuOCEmlt7bqoWMwKCixcdQZBXhNCvL1qinqqI8UrbO88u4R9GzQvKKHS+6h3eOmFt+o5cfV5kVawlE4677xw2J3reUzXAaqhSIDPZBo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(7636003)(356005)(107886003)(426003)(2616005)(2906002)(36860700001)(53546011)(83380400001)(36756003)(86362001)(31696002)(70206006)(70586007)(5660300002)(82740400003)(186003)(16526019)(4326008)(316002)(8936002)(478600001)(8676002)(31686004)(47076005)(16576012)(36906005)(6916009)(82310400003)(54906003)(26005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:55:05.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588d630e-3826-4d3e-77f9-08d9098c719d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Typo in the commit text  will post v3.

On 4/26/21 9:28 PM, Shanker Donthineni wrote:
> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device.
>
> Implement a new reset function pci_dev_acpi_reset() for probing RST
> method and execute if it is defined in the firmware.
>
> The ACPI based reset is called after the device-specific reset and
> before standard PCI hardware resets.
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  drivers/pci/pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..6dadb19848c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5054,6 +5054,35 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
>  
> +/**
> + * pci_dev_acpi_reset - do a function level reset using _RST method
> + * @dev: device to reset
> + * @probe: check if _RST method is included in the acpi_device context.
> + */
> +static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> +{
> +#ifdef CONFIG_ACPI
> +	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> +
> +	/* Return -ENOTTY if _RST method is not included in the dev context */
> +	if (!handle || !acpi_has_method(handle, "_RST"))
> +		return -ENOTTY;
> +
> +	/* Return 0 for probe phase indicating that we can reset this device */
> +	if (probe)
> +		return 0;
> +
> +	/* Invoke _RST() method to perform a function level reset */
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> +		pci_warn(dev, "Failed to reset the device\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +#else
> +	return -ENOTTY;
> +#endif
> +}
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holding
>   * the @dev mutex lock.
> @@ -5089,6 +5118,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	 * reset mechanisms might be broken on the device.
>  	 */
>  	rc = pci_dev_specific_reset(dev, 0);
> +	if (rc != -ENOTTY)
> +		return rc;
> +	rc = pci_dev_acpi_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev)) {
> @@ -5127,6 +5159,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	might_sleep();
>  
>  	rc = pci_dev_specific_reset(dev, 1);
> +	if (rc != -ENOTTY)
> +		return rc;
> +	rc = pci_dev_acpi_reset(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev))

