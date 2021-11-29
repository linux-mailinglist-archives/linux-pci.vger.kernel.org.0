Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7E461409
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 12:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhK2LsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 06:48:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65252 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244263AbhK2LqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 06:46:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBP93u029599;
        Mon, 29 Nov 2021 11:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=Jx45W1IwVU2Qw4T/Hog/OsXLejOfBtQuTqJU4FdNf44=;
 b=WV9HXNaQaDEQCswdkwBYkbGBQiUIPDidG194fs/XR3UPjHNpA/6BeXDjGON03Bo9t6GH
 rBc2t8YfGKHOyMmDCUSb/p6sN9h+VIJNRnVB3UcTHkPcIF55sAlDZQOBQRzmLIsNpcnw
 9Rfo5hjTlHRJUF23Xm0f9x3VpeDA7Pecm45d333LNWdya6CDNoJlzF6uY70ZAk4ySvC2
 PorSaV5DfWjPpKwptnGIh/8MGV5ykBlUIKGk/Y+30gCkDUwahHIbFDbJpFCP/adkrDkG
 bC4nQRsstEsguBXHUF5IATJHqiXYOO7xjLuLrK06hQJw94C5yF3h8qmKBfHLfFXM8+il Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1w8y1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:42:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBa1Ph053331;
        Mon, 29 Nov 2021 11:42:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3020.oracle.com with ESMTP id 3cke4m4u8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua5LoIah5JaZtMvPSeAP+MtKyHSUi+cDH8P6XKSP07votH6dD7HMYJbDd2ot2wwZJVwXWhfeQf/U+nVxIquVBkOpBQrR+22CAqwEr91743algXNDBtS7n4f2EwxGAEiMgDhYiy14r/PmwbV4E5TCwhtChHkRt8lZ4CYK9ck5vK3NmM7NAWIQenKnsEdKPH6V58FTfWxovZNcGL9UowKjT/mP27SW0z+7aHNk6ufZoxcXykndxbxmBWbBn+yAJCJziFCvUXzBpBRLZRbBnduoeDLN/vKfN+xetO+M69ySz9spMLvLhCenbYnbPQCYxAbe2etnZJW0jjfxpCD0394ktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx45W1IwVU2Qw4T/Hog/OsXLejOfBtQuTqJU4FdNf44=;
 b=SvwMQO/AI+EahDDO5Ny3j+ETSv1/spIBZl5wvL5B0MykL56KuZnPCv1EHPstzsgBJg7ZggON3CqMDtAUg4EkRz87kibCc/Mtel4vEv0Evknh5isPUza+GpZd3qBIgBvhuX2ze5cVGlJEA0ZLD4lmZKBL/yJZOIzhPIGQ0ucLUIvYUSBhv6lrq/tVxXtVWLeDscQHzylswr8v5q8KzLvDvLeOCy7QpnRNDbyq9RH/EWm6eMJnEoxhO0yqc7pBHLXEwtT+ekI7Q39nZ4gqziXzWB49aXOVnXSHVJNvb75JW8Z4k5SkZA9pa5qOX/imwV71o6sgM8kI6ixuXF7urRgo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx45W1IwVU2Qw4T/Hog/OsXLejOfBtQuTqJU4FdNf44=;
 b=Mkw0ftgrHRMOqaFw2U6bVjFIbT+YG4g8fcoRJvqbsfqCAxD3CoV7fYMPWXvEjaVqN58a/1jHhfuZtN0JHH9W2VIMmryldwQfPDmiUp/08DqoSpZ2Yntkzs7VRG2+VCAURspbZToN9x2JvhWKrwTjiqkHr+F+cPnvFGfPKFo55ks=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1726.namprd10.prod.outlook.com
 (2603:10b6:301:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 11:42:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 11:42:46 +0000
Date:   Mon, 29 Nov 2021 14:42:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 14/23] cxl: Introduce topology host registration
Message-ID: <202111260523.BAvGTRJR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120000250.1663391-15-ben.widawsky@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 11:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75ddf310-b852-42c4-1cab-08d9b32d5c9a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1726813458178967B20757A58E669@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUqJe/jkOzjOs78QlDG6anFdSfCLqUgghnCwbWReDWwKCP1ktpyCHnLVVoHklKsB8vBQ5wL8UFIA49d9sP++gfP2VcuiZMNhqbYgRoa7sJPTEcpVcR5Zgfo9vJuwjkTAhFAukyZQIdQPcNADNTl93GzP5E+y5QCuKb287eT4hWnuIwA8xSdw1htf8fW4QmRaLD1RyvMJmly4I2d+wQw9+vzZR2mAB6+gPH9T5qZZi9FlWPLE9soz19ghLfIFPJizSJOYdzUlf+fID0IDuyg5gaqoB7SYjNTS8j5cSHtEeT5DVnRHqk6/D718RfwCtFw5Z4DzUL33wV2bHgErBV42XQffYxBRZHEFUMeWUETcpU1BZoHJrEJgvEdfwzbXkEzu7QPSQLZPbYbpupGABaHxIpb3j3Gt8dSSZt5QX/pRdpEsqc/cV3BC6iuaa0lXNeDVypnwsYHRHfvn5GrkvlsFT+/cwsIxyHnwvlgrkcQtOTV+I6MbDGSXnzk9jcz8wTqLuZyWcA/29BiEAPs0yZSb2l3rB043stDnNZLEVvS1lpnI1OQ3c2H023SoxLkbvvTnktvN7Fo/HWsToxZwik5US1whULq0ezYeiaDbAsimFGkA//v6C8y9fWFC7+4Sb0WLF35XKq3y+qa8vaYzTwfDHjCGVvpLiTVHNGjWPIjQSTo4hwMLixxHi/nSgiiyu+OMdIVGJsTFsdIVD75tn0XDiADlXIFITmSRxvKZCiMNshiwJBumOaLu/1qpIdHlf5g+So6MGNArpTANJPNQau7YDCXFJISHbyJYSl6JLd9Ab62rI7kdHdmS8qJLtPCYUD+erK1rk5mWHxz8OtauB3UXpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(4326008)(7416002)(6666004)(36756003)(66946007)(1076003)(54906003)(6486002)(6496006)(8936002)(316002)(186003)(9686003)(508600001)(86362001)(2906002)(83380400001)(66556008)(5660300002)(44832011)(66476007)(8676002)(4001150100001)(26005)(966005)(38100700002)(38350700002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x5yfMlKz5ygcdGYbaQzJdObIWjerbvSxGpqKdMX+7667q/YbV/TbMBe8HQWB?=
 =?us-ascii?Q?17ywwQ7dHv2SoVyVcrdfag0nAVG0+9IhuZ4SPvJmt0iaFcCUPQsV+31bOxF8?=
 =?us-ascii?Q?Bk+ZUYGMTyZVw4nQqaPAftpqy8zIce056OhoPZnwGoEn1a3oUmDgCzsMav/E?=
 =?us-ascii?Q?XB1nPlmio6fk1Gb/f853ll5aBM1hmgNihtfRroMqy39xh7Zy5V58mu1Oywkq?=
 =?us-ascii?Q?ehu8fACRQZX/Kfi26kFJfPT7adBgilru//qfBxTsicoi5X3Z1a+B0kUc90BS?=
 =?us-ascii?Q?RAMlYCK875qYRNBpml4DG+RAt1+ETiIfzB0bcEbeg5y5JmuJVIs5mFdqyBUn?=
 =?us-ascii?Q?lQhkXxUYZoImiLCKSUgk6LejBKg0K9nqYpJHjs5KuCXuCDL/+gqHY4aM6vBY?=
 =?us-ascii?Q?yUbm6RzitVHb4g4FpPPzVNIfQ2XQBz1NOqVFhyX6FGqromVVHLYZ9DbzOWMT?=
 =?us-ascii?Q?q/wG7xD/3+6D+t/bFUlfeJobWi2RVt2tmswJzzd0eOi9U6uRkPP6aEJFBD8L?=
 =?us-ascii?Q?6u7MOqyP56NZG4T/vrRDIs2qjM6VQBQy0+2VyxtM6Ur5QC1SiX7/+tM5gGcK?=
 =?us-ascii?Q?sZ8QbPI0LosmltYS6LdkSzBPAdZzP0PD4NWa8dqChadv12lXXKVfjclzOzYF?=
 =?us-ascii?Q?7PSyKsdU5FB4tA5hWPy/NVTba3B7W4EAZRXxoT9mvYQRjh6Xa55U2mJsxtzU?=
 =?us-ascii?Q?XCKD4a5KYK4oClxZmiGKyL8CmlBUy+yuuJcg335z7PDuFhf3FiG9gYrqIjof?=
 =?us-ascii?Q?wzXgQA/PwX7g4ij4c6pDdSmB+kS12oEvcqiQSCCB9QIC+nojPDADb+VVMDwt?=
 =?us-ascii?Q?83u1pPBaKEJvGeP6tyOXoPkOPJj7Rtequdh56esMg9Kd/pNK5tB7RbK8IwyF?=
 =?us-ascii?Q?MjLFBtEZLdZJrxg4p/CM5ucUHH5E8JmfZWBMOek39ArrsIsmBRU8mvjECdoE?=
 =?us-ascii?Q?Jx3tHMNnnePBnBySiOrRW8MHh1rOHes0u8yT3ofzWZfJ4qJNzOH9sSQ9nZIp?=
 =?us-ascii?Q?xwesaprwOC/10JTjxagkcDNg0O5kspw6g2pPxb559oSqxCjEvqyeItziHxEf?=
 =?us-ascii?Q?fPJsZBkxYiAPxCEpYNzeki2zJ9HgIX5lMuwXr7/XvGMs8noVYPeZFgz6Fqne?=
 =?us-ascii?Q?kR4ylvd1B82jYej1WSgLc8Fjl7osvxdanS5eUbRVFJeURfUbc9teeHmFDV7H?=
 =?us-ascii?Q?96435IbWLUAnaZS/T6jxc/Ly/ykhzIMPuWV+HWvii2vAMTtdOf1a6v9LgknS?=
 =?us-ascii?Q?wjZa20kUze3rjEemLj7osYI9QW1XOss09udaB36U9h0mYyt70VhYAJo2f1m2?=
 =?us-ascii?Q?Q/gN7nz/ylAgyyBIoIYqGaZ8nDgT0VGFugyU2zRp06doa229G6XPBh8MTQ/x?=
 =?us-ascii?Q?BcwSvYiCOkzjGYfJ6DA8XdnSSd/RYow3sfvRA9H6QTFjJMBvDFY/90iTQcGM?=
 =?us-ascii?Q?nnkZHDoOEQIXU82vVvRzt708bx01Q/qKnqmTeoyEgzp9wfQblfRJacpuHdnW?=
 =?us-ascii?Q?QZrYXnNTB658uI4ZLdmjwcQKkR0NvOlOKNjQJzfMBu6GXh1HbL54dCfk+3Gq?=
 =?us-ascii?Q?lBGesZBZBLuootdWTlNivBIcMXvdSevKlVh78GGua9cduVtb5SsHy7etl0V5?=
 =?us-ascii?Q?8MrL+ezSL34NIqtPmD9TdPYmZZ2q2SSQ1wHpb/5yn+s9ye9M3s+p1rGr8cKI?=
 =?us-ascii?Q?/KGkoEe/QZUPmCX7Mntkx9aVawI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ddf310-b852-42c4-1cab-08d9b32d5c9a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 11:42:46.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfPeE2pMH4P9K+rBK8lVk3RYjozigaMlmeJei8i6x2KCYFd7SVtv2xiB37LoqKTOlvpjPjuAZqE5SW9GTYfMIG1QEYbegDcEVFllMceob0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290058
X-Proofpoint-GUID: sdz2vU1qvIxmcnwM0JitNdaTeM3ncNIv
X-Proofpoint-ORIG-GUID: sdz2vU1qvIxmcnwM0JitNdaTeM3ncNIv
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,

url:    https://github.com/0day-ci/linux/commits/Ben-Widawsky/Add-drivers-for-CXL-ports-and-mem-devices/20211120-080513
base:   53989fad1286e652ea3655ae3367ba698da8d2ff
config: x86_64-randconfig-m001-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260523.BAvGTRJR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cxl/acpi.c:399 cxl_acpi_probe() error: uninitialized symbol 'root_port'.

vim +/root_port +399 drivers/cxl/acpi.c

4812be97c015bd Dan Williams     2021-06-09  383  static int cxl_acpi_probe(struct platform_device *pdev)
4812be97c015bd Dan Williams     2021-06-09  384  {
3b94ce7b7bc1b4 Dan Williams     2021-06-09  385  	int rc;
4812be97c015bd Dan Williams     2021-06-09  386  	struct cxl_port *root_port;
4812be97c015bd Dan Williams     2021-06-09  387  	struct device *host = &pdev->dev;
7d4b5ca2e2cb5d Dan Williams     2021-06-09  388  	struct acpi_device *adev = ACPI_COMPANION(host);
f4ce1f766f1ebf Dan Williams     2021-10-29  389  	struct cxl_cfmws_context ctx;
4812be97c015bd Dan Williams     2021-06-09  390  
6b4661f8037e4f Ben Widawsky     2021-11-19  391  	rc = cxl_register_topology_host(host);
6b4661f8037e4f Ben Widawsky     2021-11-19  392  	if (rc)
6b4661f8037e4f Ben Widawsky     2021-11-19  393  		return rc;
6b4661f8037e4f Ben Widawsky     2021-11-19  394  
6b4661f8037e4f Ben Widawsky     2021-11-19  395  	rc = devm_add_action_or_reset(host, clear_topology_host, host);
6b4661f8037e4f Ben Widawsky     2021-11-19  396  	if (rc)
6b4661f8037e4f Ben Widawsky     2021-11-19  397  		return rc;
6b4661f8037e4f Ben Widawsky     2021-11-19  398  
6b4661f8037e4f Ben Widawsky     2021-11-19 @399  	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);
                                                                                                               ^^^^^^^^^^
Uninitialized.

4812be97c015bd Dan Williams     2021-06-09  400  	if (IS_ERR(root_port))
4812be97c015bd Dan Williams     2021-06-09  401  		return PTR_ERR(root_port);
4812be97c015bd Dan Williams     2021-06-09  402  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
4812be97c015bd Dan Williams     2021-06-09  403  
3b94ce7b7bc1b4 Dan Williams     2021-06-09  404  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
7d4b5ca2e2cb5d Dan Williams     2021-06-09  405  			      add_host_bridge_dport);
f4ce1f766f1ebf Dan Williams     2021-10-29  406  	if (rc < 0)
f4ce1f766f1ebf Dan Williams     2021-10-29  407  		return rc;
3b94ce7b7bc1b4 Dan Williams     2021-06-09  408  
f4ce1f766f1ebf Dan Williams     2021-10-29  409  	ctx = (struct cxl_cfmws_context) {
f4ce1f766f1ebf Dan Williams     2021-10-29  410  		.dev = host,
f4ce1f766f1ebf Dan Williams     2021-10-29  411  		.root_port = root_port,
f4ce1f766f1ebf Dan Williams     2021-10-29  412  	};
f4ce1f766f1ebf Dan Williams     2021-10-29  413  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
3e23d17ce1980c Alison Schofield 2021-06-17  414  
3b94ce7b7bc1b4 Dan Williams     2021-06-09  415  	/*
3b94ce7b7bc1b4 Dan Williams     2021-06-09  416  	 * Root level scanned with host-bridge as dports, now scan host-bridges
3b94ce7b7bc1b4 Dan Williams     2021-06-09  417  	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
3b94ce7b7bc1b4 Dan Williams     2021-06-09  418  	 */
8fdcb1704f61a8 Dan Williams     2021-06-15  419  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
3b94ce7b7bc1b4 Dan Williams     2021-06-09  420  			      add_host_bridge_uport);
f4ce1f766f1ebf Dan Williams     2021-10-29  421  	if (rc < 0)
f4ce1f766f1ebf Dan Williams     2021-10-29  422  		return rc;
8fdcb1704f61a8 Dan Williams     2021-06-15  423  
8fdcb1704f61a8 Dan Williams     2021-06-15  424  	if (IS_ENABLED(CONFIG_CXL_PMEM))
8fdcb1704f61a8 Dan Williams     2021-06-15  425  		rc = device_for_each_child(&root_port->dev, root_port,
8fdcb1704f61a8 Dan Williams     2021-06-15  426  					   add_root_nvdimm_bridge);
8fdcb1704f61a8 Dan Williams     2021-06-15  427  	if (rc < 0)
8fdcb1704f61a8 Dan Williams     2021-06-15  428  		return rc;
f4ce1f766f1ebf Dan Williams     2021-10-29  429  
8fdcb1704f61a8 Dan Williams     2021-06-15  430  	return 0;
4812be97c015bd Dan Williams     2021-06-09  431  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

