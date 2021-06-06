Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A239CD52
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 07:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFFFCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 01:02:36 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:10647
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229630AbhFFFCf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 01:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODWoHCy/Hi7pGjW+y/J10wdK9843zB3ig/ozNtWAFecXSgFsqwBNm4/u/YIQqwCW8hvosXqz4bikOcmlLjGSoqcEbeSHLuVZe/2cCwX8ALCw5LTiX0CbVrvK5tpEhFRQ8weSJ1b/EOfdB8DSnAFWg6eRDOWD/YclKmrHf2K8oekKbGFFq7Z1CUOMy5+saDLVFeI05lkvaeRoG5ndI1juHHMmwc9Q9XHcebz3OIt4/JfijVg8AfxDgoX19qzWY2tXyDlfGyotthn+ZfqiaR+i0htRrevzPNwXITDLaLxiSbNQGYR6SlfUecEkWjlW/rNfhgpTYKZgLIZ2Teu6J8P3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Yx3TvYUSFTSj88OpaJC2HT3T7X3XzTURt1o8HnWzE=;
 b=evnXv/kuKi0VhmUliLjYRpMPl48AbDvjAgjQbOYzxugXOOMYrq/hYRu6f1uZJwT+xaNansG/lhOF+DWgzWggomd0Zw+D/pWOelF8JISoiSa55KVsdV1YeICEVC4jkOMr0/8phu3bo0Z4OpzUpon6iMAg5h32sGlBCMBJTpE5GcXKc9KDSpq/r1bjyzAMstxPXoQJEcI3ZF3sJjIZTRaAJEbop3LPd4FhcFFXLVxPxE8E+rPfK+FN/Uaq7/tFxAH/2LVeOR6D/7WMihNM+ltc4lOPVD6993DyBggtDxwSuRx0IGWWVoqfkyPn0myE1a5YCx4EjZX+UasI8VDeAOKnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Yx3TvYUSFTSj88OpaJC2HT3T7X3XzTURt1o8HnWzE=;
 b=ty57IaD1B/i/d0JU9rLl8SN7ClPOJniqo9kXIZc9Ic6jrHV+eyxT1ZIfvgCCKVbeVUM+f9w7VLzzMMWUYtzwyq0CwuqmRAYZwze1VvsaRUawmpxut3JQuL8vC300VvvoYXoEEfeVWRp+m9ZBrV4UpU92hcGegHG3CfF1hhGpntiUbaPRzcA3CHua7LeKZdQrp+8Rtnfr49UULSrDGO8dBImvFx9s+bueiNILVJzQ+KDr8NR+ob5TENLmHi+Vk7WaI3zmS0l68p9c/HX5GZfJmoAE9okKs3ebNE/5lyzjF0B64chroWrsE4H6sJC10xEMze65hIH7p9lknS0+eo59jw==
Received: from MW4PR04CA0021.namprd04.prod.outlook.com (2603:10b6:303:69::26)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Sun, 6 Jun
 2021 05:00:45 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::d4) by MW4PR04CA0021.outlook.office365.com
 (2603:10b6:303:69::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:44 +0000
Received: from [10.20.112.58] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 05:00:42 +0000
Subject: Re: [PATCH v5 5/7] PCI: Add support for a function level reset based
 on _RST method
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210605205317.GA2254430@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <b24be059-4f90-f1b5-b49c-ba7076ace9ba@nvidia.com>
Date:   Sun, 6 Jun 2021 00:00:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210605205317.GA2254430@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b688ec28-5d5e-4ef2-36f9-08d928a80ab0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2477:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2477FB8FFD96F420C377D13BC7399@SN1PR12MB2477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vl/S3n1NcpVO9+cyokZCNzDP0Rvp1E8z9tfraG46jUBWyfa1/hxc84HErl8okN1eIxtMYaVSmix//MqYXsywMdlMv1ymt63aGp3zTVbWz1Y8U78fhMcVylUKSfBECzsKkL8uOGkPsK8IbEm3Bc6sll83p8UfajCeIc5VUBioEFScp4sau3YLBc2d/tfQG0XPuUK9Y17sQ2O792gq3bZvJoJxKonrQIWF+YgOBAIoHKOZSyUCIcwRWdL7cz0fUgpScxGFgkq7S/BehLd/E74tJB+xM63qIjNwyCeuGHb7SltKGYKT68Li9aXcJtuW6v94w2gi78jwN6bzRRdKKs03FjNIeQb1LULOORSFFure+DG+rdCgyyy5/+hsLu/9yZHShw4ex3FdW7SufUw1ij9xqmrKT/a9jwLCj4FAtNaYpjLBN6WIveEAOCwPPAGDBTVJX7PyrcD72dDffbHVK5IXey+1AGjlqzM0LR5bknFoSrAVHOxwO2ugYLyiUQ3S0PTWKQVYcvrqUhT0Xn/VvV5LHw0tLBIeD4Ao9+0BUi2LOgb9JfwwIXqiqGvySmR/om3yEd5gN37CV3uqeUizK0wI2WDmnJ231IDKmQVb1CI6py2z6H74pNn4HKyY6tVZ840VtSBNdvtbgADOFW/0s09iGw7MY5IYbHzU16q9HHFjjUkTiVh4Ens2hVUQVW+r7JwJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(478600001)(336012)(31696002)(53546011)(8936002)(5660300002)(70206006)(36860700001)(70586007)(426003)(8676002)(31686004)(316002)(82310400003)(26005)(16526019)(36906005)(36756003)(186003)(4326008)(7636003)(86362001)(83380400001)(7416002)(2616005)(2906002)(16576012)(110136005)(356005)(54906003)(82740400003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:44.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b688ec28-5d5e-4ef2-36f9-08d928a80ab0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/5/21 3:53 PM, Bjorn Helgaas wrote:
> This is a little sketchy.  We shouldn't be doing device config stuff
> after device_add() because that's when it becomes available for
> drivers to bind to the device.  If we do anything with the device
> after that point, we may interfere with a driver.
>
> I think the problem is that we don't call acpi_bind_one() until
> device_add().  There's some hackery in pci-acpi.c to deal with a
> similar problem for something else -- see acpi_pci_bridge_d3().
>
> I don't know how to fix this yet.  Here's the call graph that I think
> is relevant:
I've refactored pci_dev_acpi_reset() to avoid dependency on acpi_bind_one().
It can be called any time after creating pci_dev object. The code logic is
not exactly same as acpi_pci_bridge_d3() but similar flow. No need to set
ACPI_COMPANION since it would be updated eventually after probing the
reset methods.

Please review the below code and provide suggestions for the next step.

Updated patch:

[PATCH v5 5/7] PCI: Add support for ACPI _RST reset method

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware. The ACPI binding
information is available only after calling device_add(). Since the
ACPI_COMPANION was not done before calling pci_init_reset_methods(),
use acpi_pci_find_companion() to know the ACPI binding.

The default priority of the ACPI reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci-acpi.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e217592..c344c33f5c910 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -934,6 +934,36 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)

 static struct acpi_device *acpi_pci_find_companion(struct device *dev);

+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+       acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+       /* Find out ACPI_HANDLE if not available in the device context */
+       if (!handle) {
+               handle = acpi_device_handle(acpi_pci_find_companion(&dev->dev));
+               if (!handle)
+                       return -ENOTTY;
+       }
+
+       if (!acpi_has_method(handle, "_RST"))
+               return -ENOTTY;
+
+       if (probe)
+               return 0;
+
+       if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+               pci_warn(dev, "ACPI _RST failed\n");
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
        const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bbed852d977f1..5726d120b70a2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5122,6 +5122,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
        { &pci_dev_specific_reset, .name = "device_specific" },
+       { &pci_dev_acpi_reset, .name = "acpi" },
        { &pcie_reset_flr, .name = "flr" },
        { &pci_af_flr, .name = "af_flr" },
        { &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13ec6bd6f4f76..f3974ed1a99c2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -703,7 +703,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
 #else
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+       return -ENOTTY;
+}
+
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
        return -ENODEV;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6e9bc4f9cdab4..a7f063da2fe5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,7 +49,7 @@
                               PCI_STATUS_SIG_TARGET_ABORT | \
                               PCI_STATUS_PARITY)

-#define PCI_RESET_METHODS_NUM 5
+#define PCI_RESET_METHODS_NUM 6



