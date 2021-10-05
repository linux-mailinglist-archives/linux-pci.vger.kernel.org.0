Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928842345A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhJEXPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 19:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236930AbhJEXPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 19:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633475610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zj1Pqa/nW4zCjDbiBULlfMptYD+zwkzqfmywnaZHqKA=;
        b=jJBSbIunMYTY7kD+1ilERg1wn47h9tTdeuzgowBb91+BCkFCWzm1ob4HwAkEzlbyJVLF2q
        WS6naLPkmXN+Yzf0t3zb+bPz/DQ7ckqFISUn8eECxxWL9jdTp/q+RXogjwlcZqO5jDXdq5
        fm5SHsBobNQE70uJtEZ2kW8KTdVSI7Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-NP7J7YWaM-mdmIXzqeX-Ng-1; Tue, 05 Oct 2021 19:13:29 -0400
X-MC-Unique: NP7J7YWaM-mdmIXzqeX-Ng-1
Received: by mail-oi1-f200.google.com with SMTP id y5-20020aca3205000000b0027644481fe7so581040oiy.10
        for <linux-pci@vger.kernel.org>; Tue, 05 Oct 2021 16:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zj1Pqa/nW4zCjDbiBULlfMptYD+zwkzqfmywnaZHqKA=;
        b=CADr+/qBqMw2VffYqtS8FafTkbv7+rKH2Edz19ha5+uA/xWGF80Q7WHdlx8jgonxnS
         XMYRFhZOFqZXrBTejR99Y33Tof3y7ADfukO2xW69ybWQo4JEbzojrc/kiXNRkpM/9T6L
         L4ia5YXSRzL9tSqTJAJHuYd7jO3H+R88H4nh0EdhzmQYaLeGt9sf8VxNXRCitl2AUcM1
         ILVBeOkg0Y+EKOyxcTQG4Z66ksoIHGl+4P7UF0ZjZ1GdaqkNVFQWqtoNGNwJwI5OXKQq
         cxOW9RrAp3Dh/d6p3YmkURfpPgmByYLLqoGQ+s+JahSa/YndDB6+YSDP6crxz4CWFyhW
         KziQ==
X-Gm-Message-State: AOAM5304lJVR+Bnfe+nDheQSbwIq6k25/gro3qgsvkWyDl5SFmPfC8fZ
        o0Mrj2zg6O5jXdmo5ehZhiwUNSZFTq7CKo/2LbOdQoxrhlqkzEFRtGaVLKqLLMGCTwSlJMC7TmN
        nsXk+AoF4Fh5+nCHBLSRn
X-Received: by 2002:a9d:609a:: with SMTP id m26mr17156155otj.226.1633475608493;
        Tue, 05 Oct 2021 16:13:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnrBD3X8yCjj7mK0ad54Ro3UQYC86p0POKvspHM8DhJ0GW84v5/9RUjQihQJWQd/OQb4+tew==
X-Received: by 2002:a9d:609a:: with SMTP id m26mr17156133otj.226.1633475608192;
        Tue, 05 Oct 2021 16:13:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c12sm3805488oos.16.2021.10.05.16.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:13:27 -0700 (PDT)
Date:   Tue, 5 Oct 2021 17:13:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
Message-ID: <20211005171326.3f25a43a.alex.williamson@redhat.com>
In-Reply-To: <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
        <20210914104301.48270518.alex.williamson@redhat.com>
        <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
        <20210915103235.097202d2.alex.williamson@redhat.com>
        <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 Oct 2021 18:02:24 +1300
Matthew Ruffell <matthew.ruffell@canonical.com> wrote:

> Hi Alex,
> 
> Have you had an opportunity to have a look at this a bit deeper?
> 
> On 16/09/21 4:32 am, Alex Williamson wrote:
> > 
> > Adding debugging to the vfio-pci interrupt handler, it's correctly
> > deferring the interrupt as the GPU device is not identifying itself as
> > the source of the interrupt via the status register.  In fact, setting
> > the disable INTx bit in the GPU command register while the interrupt
> > storm occurs does not stop the interrupts.
> > 
> > The interrupt storm does seem to be related to the bus resets, but I
> > can't figure out yet how multiple devices per switch factors into the
> > issue.  Serializing all bus resets via a mutex doesn't seem to change
> > the behavior.
> > 
> > I'm still investigating, but if anyone knows how to get access to the
> > Broadcom datasheet or errata for this switch, please let me know.  
> 
> We have managed to obtain a recent errata for this switch, and it 
> doesn't
>  mention any interrupt storms with nested switches. What would 
> I be looking for
>  in the errata? I cannot share our copy, sorry.

I dug back into this today and I'm thinking that it doesn't have
anything to do with the PCIe switch hardware.  In my case, I believe
the switch is mostly just imposing interrupt sharing between pairs of
GPUs under the switches.  For example, in the case of the GRID K1, the
1st & 3rd share an interrupt, as do the 2nd & 4th, so I believe I could
get away with assigning one from each shared set together.

The interrupt sharing is a problem because occasionally one of the GPUs
will continuously stomp on the interrupt line while there's no handler
configured, the other GPU replies "not me", and the kernel eventually
squashes the line.

In one case I see this happening when vfio-pci calls
pci_free_irq_vectors() when we're tearing down the MSI interrupt.  This
is the nastiest case because this function wants to clear DisINTx in
pci_intx_for_msi(), where the free-irq-vectors function doesn't even
return to vfio-pci code so that we could mask INTx before the interrupt
storm does its thing.  I've got a workaround for this in the patch I'm
playing with below, but it's exceptionally hacky.

Another case I see is that DisINTx will be cleared while the device is
still screaming on the interrupt line, but userspace doesn't yet have a
handler setup.  I've had a notion that we need some sort of guard
handler to protect the host from such situations, ie. a handler that
only serves to squelch the device in cases where we could have a shared
interrupt.  The patch below also includes swapping in this handler
between userspace interrupt configurations.

With both of these together, I'm so far able to prevent an interrupt
storm for these cards.  I'd say the patch below is still extremely
experimental, and I'm not sure how to get around the really hacky bit,
but it would be interesting to see if it resolves the original issue.
I've not yet tested this on a variety of devices, so YMMV.  Thanks,

Alex

(patch vs v5.14)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 318864d52837..c8500fcda5b8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -347,6 +347,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
 	}
 
+	vfio_intx_stub_init(vdev);
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	if (vdev->pci_2_3 && (cmd & PCI_COMMAND_INTX_DISABLE)) {
 		cmd &= ~PCI_COMMAND_INTX_DISABLE;
@@ -447,6 +448,14 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		kfree(dummy_res);
 	}
 
+	/*
+	 * Set known command register state, disabling MSI/X (via busmaster)
+	 * and INTx directly.  At this point we can teardown the INTx stub
+	 * handler initialized from the SET_IRQS teardown above.
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	vfio_intx_stub_exit(vdev);
+
 	vdev->needs_reset = true;
 
 	/*
@@ -464,12 +473,6 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		pci_save_state(pdev);
 	}
 
-	/*
-	 * Disable INTx and MSI, presumably to avoid spurious interrupts
-	 * during reset.  Stolen from pci_reset_function()
-	 */
-	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
-
 	/*
 	 * Try to get the locks ourselves to prevent a deadlock. The
 	 * success of this is dependent on being able to lock the device,
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 869dce5f134d..31978c1b0103 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -139,6 +139,44 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static irqreturn_t vfio_intx_stub(int irq, void *dev_id)
+{
+	struct vfio_pci_device *vdev = dev_id;
+
+	if (pci_check_and_mask_intx(vdev->pdev))
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
+void vfio_intx_stub_init(struct vfio_pci_device *vdev)
+{
+	char *name;
+
+	if (vdev->nointx || !vdev->pci_2_3 || !vdev->pdev->irq)
+		return;
+
+	name = kasprintf(GFP_KERNEL, "vfio-intx-stub(%s)",
+			 pci_name(vdev->pdev));
+	if (!name)
+		return;
+
+	if (request_irq(vdev->pdev->irq, vfio_intx_stub,
+			IRQF_SHARED, name, vdev))
+		kfree(name);
+
+	vdev->intx_stub = true;
+}
+
+void vfio_intx_stub_exit(struct vfio_pci_device *vdev)
+{
+	if (!vdev->intx_stub)
+		return;
+
+	kfree(free_irq(vdev->pdev->irq, vdev));
+	vdev->intx_stub = false;
+}
+
 static int vfio_intx_enable(struct vfio_pci_device *vdev)
 {
 	if (!is_irq_none(vdev))
@@ -153,6 +191,8 @@ static int vfio_intx_enable(struct vfio_pci_device *vdev)
 
 	vdev->num_ctx = 1;
 
+	vfio_intx_stub_exit(vdev);
+
 	/*
 	 * If the virtual interrupt is masked, restore it.  Devices
 	 * supporting DisINTx can be masked at the hardware level
@@ -231,6 +271,7 @@ static void vfio_intx_disable(struct vfio_pci_device *vdev)
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
+	vfio_intx_stub_init(vdev);
 }
 
 /*
@@ -258,6 +299,8 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 	if (!vdev->ctx)
 		return -ENOMEM;
 
+	vfio_intx_stub_exit(vdev);
+
 	/* return the number of supported vectors if we can't get all: */
 	cmd = vfio_pci_memory_lock_and_enable(vdev);
 	ret = pci_alloc_irq_vectors(pdev, 1, nvec, flag);
@@ -266,6 +309,7 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 			pci_free_irq_vectors(pdev);
 		vfio_pci_memory_unlock_and_restore(vdev, cmd);
 		kfree(vdev->ctx);
+		vfio_intx_stub_init(vdev);
 		return ret;
 	}
 	vfio_pci_memory_unlock_and_restore(vdev, cmd);
@@ -388,6 +432,7 @@ static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
 static void vfio_msi_disable(struct vfio_pci_device *vdev, bool msix)
 {
 	struct pci_dev *pdev = vdev->pdev;
+	pci_dev_flags_t dev_flags = pdev->dev_flags;
 	int i;
 	u16 cmd;
 
@@ -399,19 +444,22 @@ static void vfio_msi_disable(struct vfio_pci_device *vdev, bool msix)
 	vfio_msi_set_block(vdev, 0, vdev->num_ctx, NULL, msix);
 
 	cmd = vfio_pci_memory_lock_and_enable(vdev);
-	pci_free_irq_vectors(pdev);
-	vfio_pci_memory_unlock_and_restore(vdev, cmd);
-
 	/*
-	 * Both disable paths above use pci_intx_for_msi() to clear DisINTx
-	 * via their shutdown paths.  Restore for NoINTx devices.
+	 * XXX pci_intx_for_msi() will clear DisINTx, which can trigger an
+	 * INTx storm even before we return from pci_free_irq_vectors(), even
+	 * as we'll restore the previous command register immediately after.
+	 * Hack around it by masking in a dev_flag to prevent such behavior.
 	 */
-	if (vdev->nointx)
-		pci_intx(pdev, 0);
+	pdev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
+	pci_free_irq_vectors(pdev);
+	pdev->dev_flags = dev_flags;
+
+	vfio_pci_memory_unlock_and_restore(vdev, cmd);
 
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
+	vfio_intx_stub_init(vdev);
 }
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 5a36272cecbf..709d497b528c 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -128,6 +128,7 @@ struct vfio_pci_device {
 	bool			needs_reset;
 	bool			nointx;
 	bool			needs_pm_restore;
+	bool			intx_stub;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	struct vfio_pci_reflck	*reflck;
@@ -151,6 +152,9 @@ struct vfio_pci_device {
 #define is_irq_none(vdev) (!(is_intx(vdev) || is_msi(vdev) || is_msix(vdev)))
 #define irq_is(vdev, type) (vdev->irq_type == type)
 
+extern void vfio_intx_stub_init(struct vfio_pci_device *vdev);
+extern void vfio_intx_stub_exit(struct vfio_pci_device *vdev);
+
 extern void vfio_pci_intx_mask(struct vfio_pci_device *vdev);
 extern void vfio_pci_intx_unmask(struct vfio_pci_device *vdev);
 

