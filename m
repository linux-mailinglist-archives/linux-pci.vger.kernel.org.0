Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97139CF81
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFO3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 10:29:54 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:5601
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230088AbhFFO3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 10:29:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtdhZmmqO1DB2n3QVVEldUaLGHVo40qfwt8jMZbm4cgDhqSsM4FVURpu5dl+rQsXttcNt1Poi8K7P3EDBPPW2pqw3SzL5jj4A0LfL/ZRa5yTlzNUDw/fRMA9FTPQ+WAYi7PKI1EWYbxJqbh/lVUW4VS16c96MtArn17S354Q38KGqxOvMjV34+5sOykx/POVaZEJ4y24yOF9/rSId3lfT732ta90Tk76Zu2IWI18LSE4hiBierWX7/9insVm8XbFsvtriKtmICW+KjoPje8o4l8pzkia8dnpszo8rPtP4B//mNfsS+swC0Tq7RwNfj62mbt3vwYQHfkGgqLZFpszyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNu8Hn88YNlDRjq0Uo55+5pgC3SrTTIFe3s2K2GW+1c=;
 b=fJiHNmoqEs1SkHQJwTEH0Tgnr7RGD+Qc6kAGFKLAWR5w4M7iNMBh/qjhIWvHAsHgae0ieHirFXV6eBAqfXIZu6S0Ju2WcUE0D1OBN1D87sFR55S7ny7AQf+V2wQP3UZriPCACIXC5+grQgd0YKThM4ML3pkb+TrXFLyJE6LurLwlX+4ELc1cD8S8/RIizOwKwAyyX8BGEvD/MSdsQGVpJoPGgFv/I6hPPB22N8pdVHw1Mmmk8FWOjNHqy1EwtsHL0j2Q9QLwQb/5EY/XTCEylGLYYNb5YertBmy9phMzQumYK7nKphwMW0Y6l15kUmFBDUL0CjlzWdGB0eGSQGb1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNu8Hn88YNlDRjq0Uo55+5pgC3SrTTIFe3s2K2GW+1c=;
 b=ZrX8a9ub3jGFb0hsObUNsLPvBQqsXvBXL46OHeExIQTostTrmzEzNBkP+rU/2vPAu56gqEmV6f0yFx2lzxLJvxbXl6v4rEnADBI66v0G0RxYROHsBNB4HB5cmemKCF6y+tbA2FYC6hLLve3FuZoXa6BOLD4nnNKj7w9IYAkaPDTGy/oBAG6YfZE3aU4gEZ2UHLnK057+NHPsAQZihadkGaOPfBOAAiKYXUiPodFzEUL7t5quhkGSEJI8iU8y7oo2jEUoSC9vk7mOLhkaVaVMhYzSdls4PNSX+lP1pn9UmfX0vvqMphOQsHH7Pae3/tgKC2a7frZn0LjUt448P4LesQ==
Received: from BN6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:404:65::21)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 14:28:00 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::61) by BN6PR17CA0011.outlook.office365.com
 (2603:10b6:404:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Sun, 6 Jun 2021 14:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 14:27:59 +0000
Received: from [10.20.112.58] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 14:27:58 +0000
Subject: Re: [PATCH v5 4/7] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-5-ameynarkhede03@gmail.com>
 <20210606125800.GA76573@rocinante.localdomain>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <87aaf482-dbfe-adaa-eea0-1c6febe6503c@nvidia.com>
Date:   Sun, 6 Jun 2021 09:27:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210606125800.GA76573@rocinante.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a99e89-8d9a-44df-9ee9-08d928f74938
X-MS-TrafficTypeDiagnostic: BN9PR12MB5354:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53546D15DCECC904A59E23AEC7399@BN9PR12MB5354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ittOncTKSBdREUpA9RSgAC7Lbdy2VHN2XkDImCC9AvxHsupCHhlFRycjCDzecHcxIsc53QqBBz08HTQiXjb2ou9uzoRwEk/fDuhdyfk5bP/ayB0cPt2R5+86QDoO2NqUYNLUTZXZnfNRFDfOcuuTWGFChKkif9cYqtpgFBR8iI+qmBKLXGDeLlnuFk+5ZtvvqlRCmuXn5gEqpP3HK/3eR4hqtBmU19pR6o6gQlSLldZBzMdrHWRQQ9JoIutMRb1mK0hj1SIHIhqZScrPwkHQR/c/Ox7ZzxoujWvH5wUNL9benIGkZxyvD/SA+SRxue4WZ+/s6fqQZ0RX5kbqeDBpWut7Wp9xskLHtmBt1hKjQkAxbh6Xs1kGuF5Q9iqK+HEHxnhC8ZGaN+6Zvtii5z/JBGuC08odK7csJzKMos9nyxt7C0QO57zhR/wJ+lvxkbsVIW1/AFjMSCsih8Pqc9HTm1c6a7eO44AcIQl8cYxSgGjTko8NyfyyVokgiMp42k2W7KEC6wXlStndihoSMCjFF0MrulBFZl9Ru8z+DLPqrMvuJS11PU88VzOsRg30+TutbUM+P88V21jN8sVubxO9skrJ0RezNhE+FdQqdNhBdvu9B0k7VCWCuHqvz7DCMDG/Rb1NZHWAAPlfo+xSd4mPgfqloCQOKCKYI1M2QmSMEUjpbx+tH2ZravC+HlfD7o/f
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(36860700001)(8676002)(426003)(186003)(26005)(36756003)(86362001)(16526019)(53546011)(336012)(478600001)(2616005)(8936002)(70586007)(70206006)(7636003)(82740400003)(54906003)(110136005)(16576012)(316002)(5660300002)(4326008)(36906005)(66574015)(47076005)(83380400001)(356005)(2906002)(31696002)(31686004)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 14:27:59.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a99e89-8d9a-44df-9ee9-08d928f74938
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 6/6/21 7:58 AM, Krzysztof Wilczyński wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Amey and Shanker,
>
> [...]
>> +static ssize_t reset_method_show(struct device *dev,
>> +                              struct device_attribute *attr,
>> +                              char *buf)
>> +{
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +     ssize_t len = 0;
>> +     int i, prio;
>> +
>> +     for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
>> +             for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
>> +                     if (prio == pdev->reset_methods[i]) {
>> +                             len += sysfs_emit_at(buf, len, "%s%s",
>> +                                                  len ? "," : "",
>> +                                                  pci_reset_fn_methods[i].name);
>> +                             break;
>> +                     }
>> +             }
>> +
>> +             if (i == PCI_RESET_METHODS_NUM)
>> +                     break;
>> +     }
>> +
>> +     return len;
>> +}
> Make sure to include trailing newline when exposing values through the
> sysfs object to the userspace in the above show() function.

Agree new line is needed. Will fix it.
> [...]
>> +static ssize_t reset_method_store(struct device *dev,
>> +                               struct device_attribute *attr,
>> +                               const char *buf, size_t count)
> [...]
>> +
>> +     while ((name = strsep((char **)&buf, ",")) != NULL) {
> [...]
>
> This is something that I wonder could benefit from the following:
>
>   char *options, *end;
>
>   if (count >= (PAGE_SIZE - 1))
>         return -EINVAL;
>
>   options = kstrndup(buf, count, GFP_KERNEL);
>   if (!options)
>         return -ENOMEM;
>
>   while ((name = strsep(&options, ",")) != NULL) {
>         ...
>   }
>
>   ...
>
>   kfree(options);
>
> Why?  To avoid changing the string buffer that has been passed to
> reset_method_store() as strsep() while parsing will update the content
> of the buffer.  The cast to (char **), aside of most definitely allowing
> to suppress the probable compiler warning, will also allow for what
> should be a technically a constant string (to which we got a pointer to)
> to be modified.  I am not sure how much could this be of a problem, but
> I would try not to do it, if possible.

Thanks, will use temporary buffer for parsing string.
>
> [...]
>> +set_reset_methods:
>> +     memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(reset_method);
> A small nitpikc: customary there is no space (a newline) between the
> function and the macro, the macro follows immediately after.

Will fix it.
>         Krzysztof

