Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E175A0E8E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfH2AMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 20:12:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50482 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbfH2AMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 20:12:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T0Bt63119998;
        Wed, 28 Aug 2019 20:12:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmwje9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 20:12:05 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7T0C4Cd120342;
        Wed, 28 Aug 2019 20:12:04 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmwje8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 20:12:04 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7T0A5xV031574;
        Thu, 29 Aug 2019 00:12:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2umpctmvq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 00:12:02 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T0C1sg26739146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 00:12:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44F57AE05C;
        Thu, 29 Aug 2019 00:12:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD9AAE060;
        Thu, 29 Aug 2019 00:11:59 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.202.51])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 00:11:59 +0000 (GMT)
Subject: Re: [PATCH] PCI: hotplug: Remove surplus return from a void function
To:     Krzysztof Wilczynski <kw@linux.com>,
        Scott Murray <scott@spiteful.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190826095143.21353-1-kw@linux.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <064f3f5e-cf53-b6c8-654f-4654bf146428@linux.ibm.com>
Date:   Wed, 28 Aug 2019 17:11:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826095143.21353-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/26/19 2:51 AM, Krzysztof Wilczynski wrote:
> Remove unnecessary empty return statement at the end of a void
> function in the following:
> 
>   - drivers/pci/hotplug/cpci_hotplug_core.c: cleanup_slots()
>   - drivers/pci/hotplug/cpqphp_core.c: pci_print_IRQ_route()
>   - drivers/pci/hotplug/cpqphp_ctrl.c: cpqhp_pushbutton_thread()
>   - drivers/pci/hotplug/cpqphp_ctrl.c: interrupt_event_handler()
>   - drivers/pci/hotplug/cpqphp_nvram.h: compaq_nvram_init()
>   - drivers/pci/hotplug/rpadlpar_core.c: rpadlpar_io_init()
>   - drivers/pci/hotplug/rpaphp_core.c: cleanup_slots()
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

For rpa*_core.c portions,

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

> ---
>  drivers/pci/hotplug/cpci_hotplug_core.c | 1 -
>  drivers/pci/hotplug/cpqphp_core.c       | 1 -
>  drivers/pci/hotplug/cpqphp_ctrl.c       | 4 ----
>  drivers/pci/hotplug/cpqphp_nvram.h      | 5 +----
>  drivers/pci/hotplug/rpadlpar_core.c     | 1 -
>  drivers/pci/hotplug/rpaphp_core.c       | 1 -
>  6 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index 603eadf3d965..d0559d2faf50 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -563,7 +563,6 @@ cleanup_slots(void)
>  	}
>  cleanup_null:
>  	up_write(&list_rwsem);
> -	return;
>  }
>  
>  int
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index 16bbb183695a..b8aacb41a83c 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -173,7 +173,6 @@ static void pci_print_IRQ_route(void)
>  		dbg("%d %d %d %d\n", tbus, tdevice >> 3, tdevice & 0x7, tslot);
>  
>  	}
> -	return;
>  }
>  
>  
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index b7f4e1f099d9..68de958a9be8 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -1872,8 +1872,6 @@ static void interrupt_event_handler(struct controller *ctrl)
>  			}
>  		}		/* End of FOR loop */
>  	}
> -
> -	return;
>  }
>  
>  
> @@ -1943,8 +1941,6 @@ void cpqhp_pushbutton_thread(struct timer_list *t)
>  
>  		p_slot->state = STATIC_STATE;
>  	}
> -
> -	return;
>  }
>  
>  
> diff --git a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
> index 918ff8dbfe62..70e879b6a23f 100644
> --- a/drivers/pci/hotplug/cpqphp_nvram.h
> +++ b/drivers/pci/hotplug/cpqphp_nvram.h
> @@ -16,10 +16,7 @@
>  
>  #ifndef CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
>  
> -static inline void compaq_nvram_init(void __iomem *rom_start)
> -{
> -	return;
> -}
> +static inline void compaq_nvram_init(void __iomem *rom_start) { }
>  
>  static inline int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl)
>  {
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index 182f9e3443ee..977946e4e613 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -473,7 +473,6 @@ int __init rpadlpar_io_init(void)
>  void rpadlpar_io_exit(void)
>  {
>  	dlpar_sysfs_exit();
> -	return;
>  }
>  
>  module_init(rpadlpar_io_init);
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index c3899ee1db99..18627bb21e9e 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -408,7 +408,6 @@ static void __exit cleanup_slots(void)
>  		pci_hp_deregister(&slot->hotplug_slot);
>  		dealloc_slot_struct(slot);
>  	}
> -	return;
>  }
>  
>  static int __init rpaphp_init(void)
> 

