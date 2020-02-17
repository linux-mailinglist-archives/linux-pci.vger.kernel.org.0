Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017881611C6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgBQMOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:14:16 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4181 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQMOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:14:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a83760000>; Mon, 17 Feb 2020 04:13:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:14:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Feb 2020 04:14:13 -0800
Received: from [10.24.47.202] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:14:11 +0000
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Use notification chain mechanism to
 notify EPC events to EPF
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200212112514.2000-1-kishon@ti.com>
 <20200212112514.2000-2-kishon@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <cd12fb22-702d-f639-eaf7-68ca96b3c6d0@nvidia.com>
Date:   Mon, 17 Feb 2020 17:44:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212112514.2000-2-kishon@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941622; bh=OMM5i494/gXFbrccRpTS3JbNUp8xz1TYTKuZ+laJN4A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TN+d0wgIJp8QFgOtDnXRhFxppEfLd4MWXrGMq3OJH+Nks3mCaiWetVB0mf38K/9s+
         IhvjIt0+ZgHL43KkQFgNqi7mboD7elHVtgODokpyBmp9OEmNPXRoe9B0IwjeeP+Hm8
         aEL3nKB0QiNzdSAdXw+wtycPj3Cil9sp/+7u9/Wnfi0bfCAeoXI9vSv9NZl2B3KRqy
         4E3IPNItg82Gg3Cdcrg7/XH7zjuhAtvaS+Va/bo/SW9uuaH9edP7trWtWznx/stxlR
         b/Yo04WI6O38Pjfvdekr+DuTGuvWSJ7Kh66vMYDBEwxlgPhFVwektGHsHqkNMJOU23
         EVJ7NBaZREITA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
> 
> 
> Use atomic_notifier_call_chain() to notify EPC events like linkup to EPF
> driver instead of using linkup ops in EPF driver. This is in preparation
> for adding proper locking mechanism to EPF ops. This will also enable to
> add more events (in addition to linkup) in the future.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++---
>   drivers/pci/endpoint/pci-epc-core.c           |  9 ++------
>   drivers/pci/endpoint/pci-epf-core.c           | 22 +------------------
>   include/linux/pci-epc.h                       |  8 +++++++
>   include/linux/pci-epf.h                       |  6 ++---
>   5 files changed, 23 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 5d74f81ddfe4..bddff15052cc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -360,12 +360,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>                             msecs_to_jiffies(1));
>   }
> 
> -static void pci_epf_test_linkup(struct pci_epf *epf)
> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> +                                void *data)
>   {
> +       struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
>          struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> 
>          queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
>                             msecs_to_jiffies(1));
> +
> +       return NOTIFY_OK;
>   }
> 
>   static void pci_epf_test_unbind(struct pci_epf *epf)
> @@ -546,8 +550,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>                  }
>          }
> 
> -       if (!linkup_notifier)
> +       if (linkup_notifier) {
> +               epf->nb.notifier_call = pci_epf_test_notifier;
> +               pci_epc_register_notifier(epc, &epf->nb);
> +       } else {
>                  queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
> +       }
> 
>          return 0;
>   }
> @@ -580,7 +588,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
>   static struct pci_epf_ops ops = {
>          .unbind = pci_epf_test_unbind,
>          .bind   = pci_epf_test_bind,
> -       .linkup = pci_epf_test_linkup,
>   };
> 
>   static struct pci_epf_driver test_driver = {
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2091508c1620..2f6436599fcb 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -539,16 +539,10 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>    */
>   void pci_epc_linkup(struct pci_epc *epc)
>   {
> -       unsigned long flags;
> -       struct pci_epf *epf;
> -
>          if (!epc || IS_ERR(epc))
>                  return;
> 
> -       spin_lock_irqsave(&epc->lock, flags);
> -       list_for_each_entry(epf, &epc->pci_epf, list)
> -               pci_epf_linkup(epf);
> -       spin_unlock_irqrestore(&epc->lock, flags);
> +       atomic_notifier_call_chain(&epc->notifier, 0, NULL);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_linkup);
> 
> @@ -612,6 +606,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
> 
>          spin_lock_init(&epc->lock);
>          INIT_LIST_HEAD(&epc->pci_epf);
> +       ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
> 
>          device_initialize(&epc->dev);
>          epc->dev.class = pci_epc_class;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index fb1306de8f40..93f28c65ace0 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -20,26 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
>   static struct bus_type pci_epf_bus_type;
>   static const struct device_type pci_epf_type;
> 
> -/**
> - * pci_epf_linkup() - Notify the function driver that EPC device has
> - *                   established a connection with the Root Complex.
> - * @epf: the EPF device bound to the EPC device which has established
> - *      the connection with the host
> - *
> - * Invoke to notify the function driver that EPC device has established
> - * a connection with the Root Complex.
> - */
> -void pci_epf_linkup(struct pci_epf *epf)
> -{
> -       if (!epf->driver) {
> -               dev_WARN(&epf->dev, "epf device not bound to driver\n");
> -               return;
> -       }
> -
> -       epf->driver->ops->linkup(epf);
> -}
> -EXPORT_SYMBOL_GPL(pci_epf_linkup);
> -
>   /**
>    * pci_epf_unbind() - Notify the function driver that the binding between the
>    *                   EPF device and EPC device has been lost
> @@ -214,7 +194,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
>          if (!driver->ops)
>                  return -EINVAL;
> 
> -       if (!driver->ops->bind || !driver->ops->unbind || !driver->ops->linkup)
> +       if (!driver->ops->bind || !driver->ops->unbind)
>                  return -EINVAL;
> 
>          driver->driver.bus = &pci_epf_bus_type;
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 56f1846b9d39..36644ccd32ac 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -89,6 +89,7 @@ struct pci_epc_mem {
>    * @max_functions: max number of functions that can be configured in this EPC
>    * @group: configfs group representing the PCI EPC device
>    * @lock: spinlock to protect pci_epc ops
> + * @notifier: used to notify EPF of any EPC events (like linkup)
>    */
>   struct pci_epc {
>          struct device                   dev;
> @@ -99,6 +100,7 @@ struct pci_epc {
>          struct config_group             *group;
>          /* spinlock to protect against concurrent access of EP controller */
>          spinlock_t                      lock;
> +       struct atomic_notifier_head     notifier;
>   };
> 
>   /**
> @@ -141,6 +143,12 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
>          return dev_get_drvdata(&epc->dev);
>   }
> 
> +static inline int
> +pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
> +{
> +       return atomic_notifier_chain_register(&epc->notifier, nb);
> +}
> +
>   struct pci_epc *
>   __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>                        struct module *owner);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 2d6f07556682..4993f7f6439b 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -55,13 +55,10 @@ struct pci_epf_header {
>    * @bind: ops to perform when a EPC device has been bound to EPF device
>    * @unbind: ops to perform when a binding has been lost between a EPC device
>    *         and EPF device
> - * @linkup: ops to perform when the EPC device has established a connection with
> - *         a host system
>    */
>   struct pci_epf_ops {
>          int     (*bind)(struct pci_epf *epf);
>          void    (*unbind)(struct pci_epf *epf);
> -       void    (*linkup)(struct pci_epf *epf);
>   };
> 
>   /**
> @@ -112,6 +109,7 @@ struct pci_epf_bar {
>    * @epc: the EPC device to which this EPF device is bound
>    * @driver: the EPF driver to which this EPF device is bound
>    * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
> + * @nb: notifier block to notify EPF of any EPC events (like linkup)
>    */
>   struct pci_epf {
>          struct device           dev;
> @@ -125,6 +123,7 @@ struct pci_epf {
>          struct pci_epc          *epc;
>          struct pci_epf_driver   *driver;
>          struct list_head        list;
> +       struct notifier_block   nb;
>   };
> 
>   #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
> @@ -154,5 +153,4 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>   void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
>   int pci_epf_bind(struct pci_epf *epf);
>   void pci_epf_unbind(struct pci_epf *epf);
> -void pci_epf_linkup(struct pci_epf *epf);
>   #endif /* __LINUX_PCI_EPF_H */
> --
> 2.17.1
> 

Tested with the help of series @ 
http://patchwork.ozlabs.org/project/linux-pci/list/?series=158959

Tested-by: Vidya Sagar <vidyas@nvidia.com>


