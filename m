Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862922C4097
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKYMvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 07:51:51 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:41929 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbgKYMvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 07:51:51 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.90])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id B96687545376;
        Wed, 25 Nov 2020 13:51:47 +0100 (CET)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 25 Nov
 2020 13:51:46 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-100R003f5f17775-3d78-4887-bece-db38842b427c,
                    13817E1CA0648EB9EE095497159C33290D197662) smtp.auth=groug@kaod.org
Date:   Wed, 25 Nov 2020 13:51:45 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Laurent Vivier <lvivier@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Paul Mackerras" <paulus@samba.org>, <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
Message-ID: <20201125135145.64a51c4e@bahia.lan>
In-Reply-To: <20201125111657.1141295-3-lvivier@redhat.com>
References: <20201125111657.1141295-1-lvivier@redhat.com>
        <20201125111657.1141295-3-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f9887add-59a7-4ca7-a478-288848d6728e
X-Ovh-Tracer-Id: 6008646329849649656
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudehtddggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpedvfefgtdegleduudejjeelfffghfehtdeigefggfduvdfgkeevgfeftedtjeehveenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruh
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 25 Nov 2020 12:16:57 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
> 
> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
> this is broken on pseries.
> 
> The affinity is correctly computed in msi_desc but this is not applied
> to the system IRQs.
> 
> It appears the affinity is correctly passed to rtas_setup_msi_irqs() but
> lost at this point and never passed to irq_domain_alloc_descs()
> (see commit 06ee6d571f0e ("genirq: Add affinity hint to irq allocation"))
> because irq_create_mapping() doesn't take an affinity parameter.
> 
> As the previous patch has added the affinity parameter to
> irq_create_mapping() we can forward the affinity from rtas_setup_msi_irqs()
> to irq_domain_alloc_descs().
> 
> With this change, the virtqueues are correctly dispatched between the CPUs
> on pseries.
> 

Since it is public, maybe add:

BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1702939

?

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  arch/powerpc/platforms/pseries/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 133f6adcb39c..b3ac2455faad 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  			return hwirq;
>  		}
>  
> -		virq = irq_create_mapping(NULL, hwirq);
> +		virq = irq_create_mapping_affinity(NULL, hwirq,
> +						   entry->affinity);
>  
>  		if (!virq) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);

