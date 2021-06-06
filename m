Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39E339CBCA
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 02:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFFAGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 20:06:01 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:51361
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230084AbhFFAGA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 20:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb23E4Nq4gp5/mwBedaHDPpBFhyxS09oJRteG2STcNiKUH+ZnJgTUcIeBeRvwmGMP28bSYO2szQsNKH1mHJoUZ7b9QrM+s1oafi7HAVifb3SL0cksNmgwO5tIGjkDCjnjX4X2brV/TLi+ORJPpjuS+X+g+Qlcjps/+gfH4mztS7725CYccj+4ovkMANYzeKv3nWkk43jV2l2e4N6z9MwD+jUsI4UlG0ZKyLBs2LWDDtdueURneliKkOGqKwAbpGSGZgrtwB2uamecRTVUiqet+7dQ4Z4rXxp0y8QH2ugi1QyrZ6TtsDsXgVcPLt8poGrksEqL88SEp7N+pIdipxljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toravh5CONJ2Bv5nbQv4zFXFq1TzPUi+jzrE0lz2nxY=;
 b=YeeNmri2gmn7Prsg3Nkem3V8+GGmdtfN6WtdpqdfsbDFKkWzTlDsvZQfzsIlwJodj/bEyvtsEVtsEfyQ0HgX0XunMw2wLrsajTK4Dk4gwdKRKT/vC6WkkRNoPbNmAa6dioZsn81pNkYXFk7ucmh6yPP+ZyMAEm6CRvYtDCa8VoUj/c9Z6+bJi7LqdmpF61Gt9i6QLGOv7+NR89F8wLXjJTlDA1W6Z7vzEWtPV92UembIt5VriNBLANxg3KhhC5MM9m2veB5uiYkSAQWLORR3w5++1iuqD3/wOliEQ8n0OnOGR+CRSwzciHY8L3t0Hy7Wf+W+y1n49jqPGaCe4tPWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toravh5CONJ2Bv5nbQv4zFXFq1TzPUi+jzrE0lz2nxY=;
 b=XukbS2KzOan44Kjr9mX1PKJZ0WRc77NBmVQqu4TIA20WIpJ4EvcdpE8IMuwplYJL9MXfWOhmW2nAYg0bnGyRLjRMPoY3HZb8cP+gWEfogipZOtAPil3VyDU+KaN39suDbATqIHWoJTRbKLPsQrLClpF3sO9S+ZTe7Pe7y/e71CyB09PDeH0jPYPmJCIxDaBBG49n6hk30t0MOmmxJR3RPLWMgASjkdIrbjGVJLJCMrRizfhMtgX5kyp4o7vPjRJYnQQ99H3Qtp3bg1yLf7y7pUw7Nxedr2n72D0XxZ7V1iW1lWxKsdEovDxJbARorbcEc2TqGfUXsLk0THyKtctWWg==
Received: from CO2PR04CA0198.namprd04.prod.outlook.com (2603:10b6:104:5::28)
 by DM6PR12MB4747.namprd12.prod.outlook.com (2603:10b6:5:30::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Sun, 6 Jun
 2021 00:04:10 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::b2) by CO2PR04CA0198.outlook.office365.com
 (2603:10b6:104:5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Sun, 6 Jun 2021 00:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 00:04:09 +0000
Received: from [10.20.112.58] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 00:04:07 +0000
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
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
Message-ID: <5d1b9b9b-568a-d581-8938-cac174a22f7a@nvidia.com>
Date:   Sat, 5 Jun 2021 19:04:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210605205317.GA2254430@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81617498-62a6-4fd4-307b-08d9287e9c0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4747:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47473AE59B8E97209D2DDB32C7399@DM6PR12MB4747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqMcKa+eKzgOUcDwBZv5RG4kBSlKFauI9CD4Rp1Avtzsvx7fji2mBiQGfWbmVMSc9oGN/ZUyaila6j3iNjafCLWEq+vtjiCehtqYzScSwP70/k5aVqhQ1DdzkBjNiVwPrPTAzkYydqGb5SDS8ILnTC5p2z7yLXNl23D+cSzfZRLtjFuMzZgsgJezpfzaXqB/mYyUhZP6yuyoe3IpqiL/zzkqpY1qa0vsc8kZa2hMHdgDhE+9+wMVNxFhqk1RwNEtZVWBrO9gXcvNonjUOG7H5NLWgw1BNGlnLbvRTmYpHOAxi65aM7Z2nfdHajk+JI32Oa6GdvpBYeqhBjXrShvJK8vTw8WSmjNyuHsFb/ymIqJclNel2Bg0PzoGqXARlrMAYGPYtf1MdUSvo1ppb13X4oxvT370iApJWc3xfLIx0yQ1oLhPkogzyppTENETaU1DhDkK3xPSUhP5rLZhuJpU1fkJhfLkIKNSpMiaA7906GdE7vWP4MM0EIGimf8kh0wNC3Dzpb/58z1yXUDP+wP16F7gDSl7tWwa/KeleX+2EOk4RYz0ubxN4UOHvORo13Tb+gW0wrBb5iazD38aYCYsjO4mjhxKirid9/WBzSY8mty98Cf5mCWscD+v5lcQNz4W8Z/WusutwhO7+WWemKo4PiL5l9mTE1gA4z1m5lxeHPSVbT+YCVGSnGZyBh5pTamI
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(26005)(2906002)(16576012)(316002)(53546011)(30864003)(16526019)(54906003)(110136005)(5660300002)(186003)(47076005)(31686004)(31696002)(36860700001)(86362001)(7416002)(82740400003)(336012)(7636003)(4326008)(8936002)(36756003)(478600001)(8676002)(2616005)(36906005)(70206006)(70586007)(356005)(82310400003)(426003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 00:04:09.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81617498-62a6-4fd4-307b-08d9287e9c0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4747
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/5/21 3:53 PM, Bjorn Helgaas wrote:
> Mention ACPI in the subject, e.g.,
>
>   PCI: Add support for ACPI _RST reset method
Will change in the next patch.
> On Sun, May 30, 2021 at 12:55:25AM +0530, Amey Narkhede wrote:
>> From: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> The _RST is a standard method specified in the ACPI specification. It
>> provides a function level reset when it is described in the acpi_device
>> context associated with PCI-device.
>>
>> Implement a new reset function pci_dev_acpi_reset() for probing RST
>> method and execute if it is defined in the firmware. The ACPI binding
>> information is available only after calling device_add(). To consider
>> _RST method, move pci_init_reset_methods() to end of pci_device_add()
>> and craete two sysfs entries reset & reset_methond from
>> pci_create_sysfs_dev_files()
> s/craete/create/
> s/reset_methond/reset_method/
Will fix it.
>> The default priority of the acpi reset is set to below device-specific
>> and above hardware resets.
> s/acpi/ACPI/
Will fix it.
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> Reviewed-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>  drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++---
>>  drivers/pci/pci.c       | 30 ++++++++++++++++++++++++++++++
>>  drivers/pci/probe.c     |  2 +-
>>  include/linux/pci.h     |  2 +-
>>  4 files changed, 52 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 04b3d6565..b332d7923 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1482,12 +1482,30 @@ static const struct attribute_group pci_dev_reset_attr_group = {
>>       .is_visible = pci_dev_reset_attr_is_visible,
>>  };
>>
>> +const struct attribute_group *pci_dev_reset_groups[] = {
>> +     &pci_dev_reset_attr_group,
>> +     &pci_dev_reset_method_attr_group,
>> +     NULL,
>> +};
> These should be static sysfs attributes if possible, e.g., see
> e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute").
> pci_create_sysfs_dev_files() will soon be removed completely.
>
>>  int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>>  {
>> +     int retval;
>> +
>>       if (!sysfs_initialized)
>>               return -EACCES;
>>
>> -     return pci_create_resource_files(pdev);
>> +     retval = pci_create_resource_files(pdev);
>> +     if (retval)
>> +             return retval;
>> +
>> +     retval = device_add_groups(&pdev->dev, pci_dev_reset_groups);
>> +     if (retval) {
>> +             pci_remove_resource_files(pdev);
>> +             return retval;
>> +     }
>> +
>> +     return 0;
>>  }
>>
>>  /**
>> @@ -1501,6 +1519,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
>>       if (!sysfs_initialized)
>>               return;
>>
>> +     device_remove_groups(&pdev->dev, pci_dev_reset_groups);
>>       pci_remove_resource_files(pdev);
>>  }
>>
>> @@ -1594,8 +1613,6 @@ const struct attribute_group *pci_dev_groups[] = {
>>       &pci_dev_group,
>>       &pci_dev_config_attr_group,
>>       &pci_dev_rom_attr_group,
>> -     &pci_dev_reset_attr_group,
>> -     &pci_dev_reset_method_attr_group,
>>       &pci_dev_vpd_attr_group,
>>  #ifdef CONFIG_DMI
>>       &pci_dev_smbios_attr_group,
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bbed852d9..4a7019d0b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5115,6 +5115,35 @@ static void pci_dev_restore(struct pci_dev *dev)
>>               err_handler->reset_done(dev);
>>  }
>>
>> +/**
>> + * pci_dev_acpi_reset - do a function level reset using _RST method
>> + * @dev: device to reset
>> + * @probe: check if _RST method is included in the acpi_device context.
>> + */
>> +static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
>> +{
>> +#ifdef CONFIG_ACPI
>> +     acpi_handle handle = ACPI_HANDLE(&dev->dev);
>> +
>> +     /* Return -ENOTTY if _RST method is not included in the dev context */
>> +     if (!handle || !acpi_has_method(handle, "_RST"))
>> +             return -ENOTTY;
>> +
>> +     /* Return 0 for probe phase indicating that we can reset this device */
>> +     if (probe)
>> +             return 0;
>> +
>> +     /* Invoke _RST() method to perform a function level reset */
> Superfluous comment.  Actually all the single-line comments here are
> superfluous.
Will remove in the next patch.
>> +     if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
>> +             pci_warn(dev, "Failed to reset the device\n");
> The message should mention the type of reset, e.g., "ACPI _RST failed ..."
>
Will change to pci_warn(dev, "ACPI _RST failed\n");
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +#else
>> +     return -ENOTTY;
>> +#endif
>> +}
>> +
>>  /*
>>   * The ordering for functions in pci_reset_fn_methods
>>   * is required for reset_methods byte array defined
>> @@ -5122,6 +5151,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>>   */
>>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>>       { &pci_dev_specific_reset, .name = "device_specific" },
>> +     { &pci_dev_acpi_reset, .name = "acpi" },
>>       { &pcie_reset_flr, .name = "flr" },
>>       { &pci_af_flr, .name = "af_flr" },
>>       { &pci_pm_reset, .name = "pm" },
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 90fd4f61f..eeab791a0 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>       pci_rcec_init(dev);             /* Root Complex Event Collector */
>>
>>       pcie_report_downtraining(dev);
>> -     pci_init_reset_methods(dev);
>>  }
>>
>>  /*
>> @@ -2495,6 +2494,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>       dev->match_driver = false;
>>       ret = device_add(&dev->dev);
>>       WARN_ON(ret < 0);
>> +     pci_init_reset_methods(dev);
> This is a little sketchy.  We shouldn't be doing device config stuff
> after device_add() because that's when it becomes available for
> drivers to bind to the device.  If we do anything with the device
> after that point, we may interfere with a driver.
The reason I did PCI driver attach/bind is happening from pci_bus_add_device()
after setting 'dev->match_driver = true'. I thought it's safe to update reset
methods after calling device_add() and before driver bind happens.

void pci_bus_add_device(struct pci_dev *dev)
{
    int retval;

    /*
     * Can not put in pci_device_add yet because resources
     * are not assigned yet for some devices.
     */
    pcibios_bus_add_device(dev);
    pci_fixup_device(pci_fixup_final, dev);
    pci_create_sysfs_dev_files(dev);
    pci_proc_attach_device(dev);
    pci_bridge_d3_update(dev);

    dev->match_driver = true;     
    retval = device_attach(&dev->dev);  ---- > PCI driver bind call

> I think the problem is that we don't call acpi_bind_one() until
> device_add().  There's some hackery in pci-acpi.c to deal with a
> similar problem for something else -- see acpi_pci_bridge_d3().
>
> I don't know how to fix this yet.  Here's the call graph that I think
> is relevant:
>
>   pci_scan_single_device
>     pci_scan_device
>       pci_set_of_node
>         dev->dev.of_node = of_pci_find_child_device()  <-- set OF stuff
>     pci_device_add
>       device_add
>         device_platform_notify
>           acpi_platform_notify
>             case KOBJ_ADD:
>               acpi_device_notify
>                 acpi_bind_one
>                   ACPI_COMPANION_SET()       <-- sets ACPI_COMPANION
>       pci_init_reset_methods
>         pci_dev_acpi_reset(PCI_RESET_PROBE)
>           handle = ACPI_HANDLE(&dev->dev)    <-- uses ACPI_COMPANION
>
> I think it's kind of a general problem that we currently don't have
> access to the ACPI stuff until *after* device_add().  I included
> pci_set_of_node() in the graph above because that seems sort of
> like an OF analogue of what acpi_bind_one() is doing.
>
> I would really like to do the ACPI_COMPANION setup earlier, maybe
> at the same time as pci_set_of_node().  But I don't know enough about
> what acpi_bind_one() does -- there's a lot going on in there.
>
Yes, it's a general problem ACPI binding information is available only after
calling device_platform_notify(). There are no exported functions to set
the ACPI_COMPANION like OF_NODE.

Another approach: It simplifies the code logic if we update reset methods
when creating sysfs entries 'reset' and 'reset_method'. I've verified this
code and getting an expected behavior.

root@jetson:~# cat /sys/bus/pci/devices/0009\:01\:00.0/reset_method
acpi,flr

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1427,7 +1427,7 @@ static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
 {
        struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));

-       if (!pci_reset_supported(pdev))
+       if (!pci_reset_supported(pdev) && !pci_init_reset_methods(pdev))
                return 0;

        return a->mode;
@@ -1471,7 +1471,7 @@ static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
 {
        struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));

-       if (!pci_reset_supported(pdev))
+       if (!pci_reset_supported(pdev) && !pci_init_reset_methods(pdev))
                return 0;

        return a->mode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bbed852d977f1..13654255fa3dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5115,6 +5115,32 @@ static void pci_dev_restore(struct pci_dev *dev)
                err_handler->reset_done(dev);
 }
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+       acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+       if (!handle || !acpi_has_method(handle, "_RST"))
+               return -ENOTTY;
+
+       if (probe)
+               return 0;
+
+       if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+               pci_warn(dev, "ACPI _RST failed\n");
+               return -EINVAL;
+       }
+       return 0;
+#else
+       return -ENOTTY;
+#endif
+}
+
 /*
  * The ordering for functions in pci_reset_fn_methods
  * is required for reset_methods byte array defined
@@ -5122,6 +5148,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
        { &pci_dev_specific_reset, .name = "device_specific" },
+       { &pci_dev_acpi_reset, .name = "acpi" },
        { &pcie_reset_flr, .name = "flr" },
        { &pci_af_flr, .name = "af_flr" },
        { &pci_pm_reset, .name = "pm" },
@@ -5191,7 +5218,7 @@ EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
  * Stores reset mechanisms supported by device in reset_methods byte array
  * which is a member of struct pci_dev.
  */
-void pci_init_reset_methods(struct pci_dev *dev)
+bool pci_init_reset_methods(struct pci_dev *dev)
 {
        int i, rc;
        u8 prio = PCI_RESET_METHODS_NUM;
@@ -5209,6 +5236,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
                        break;
        }
        memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
+       return pci_reset_supported(dev);
 }

 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13ec6bd6f4f76..3e871a5a21bbd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
                  enum pci_mmap_api mmap_api);

-void pci_init_reset_methods(struct pci_dev *dev);
+bool pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-void pci_init_reset_methods(struct pci_dev *dev);
+bool pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 90fd4f61f3802..275a067d7a282 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
        pci_rcec_init(dev);             /* Root Complex Event Collector */

        pcie_report_downtraining(dev);
-       pci_init_reset_methods(dev);
 }


