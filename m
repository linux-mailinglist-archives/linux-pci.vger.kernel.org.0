Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64855000A
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiFQWkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFQWkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 18:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC3522E8;
        Fri, 17 Jun 2022 15:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B2B61195;
        Fri, 17 Jun 2022 22:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0361C3411B;
        Fri, 17 Jun 2022 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655505621;
        bh=stEEcPssa79iy8Faxohn+m+scucfUzjgvbnzwZ0zwV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=seidu66a0zm+BTzBCKhnB1QQtZQOiLiUc0GXQ9gMM6D+aHbcEHQ71Y0I7aycnLrg4
         fYcAB/bp741gMtuxmsKows4AWC/m9EgW6V/9zY48nInn8y8NtsN0auAowniTB+EBoi
         eHQ0la6PWly5KrBbOPtzAfTJZrPPLnUBFpzDgEvgVjMWCJaHIbMYPkrm0Wt1V/KcWi
         CkkG4EoUeMa43hNGBW4AA77LDedNQMzy37CBj4V7mjDwkcARfXg98ZQMbjqr6ivAgl
         Ep4orNseZ8+FNzGRv2cjNRJGI0APEkKF5zcMZUb7JRYmT2AlH5tuNA/olQJHegXu/o
         4/7hSbOU3vKiQ==
Date:   Fri, 17 Jun 2022 17:40:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220617224019.GA1208614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-4-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 01:22:54PM -0700, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.

> +/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */

s/PCI/PCIe/ (up in commit log, too, I guess :))

Not that there will ever be a conventional PCI r6.0 spec, but there
was a PCI r3.0 well as a PCIe r3.0, so might as well keep them
straight.

> +struct pci_doe_mb {
> +	struct pci_dev *pdev;

Trivial, but I would put cap_offset here next to pdev because the
(pdev, cap_offset) tuple is basically the identifier for the DOE
instance.

> +	struct completion abort_c;
> +	int irq;
> +	struct pci_doe_protocol *prots;
> +	int num_prots;
> +	u16 cap_offset;

> +static void pci_doe_abort_start(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	val = PCI_DOE_CTRL_ABORT;
> +	if (doe_mb->irq >= 0)

Is zero a valid IRQ?  In general, I don't think it is, but maybe this
is a special case.  Or maybe this is actually the "Interrupt Message
Number" mentioned in sec 6.30.3?  If so maybe something other than
"irq" would be a better name here.

Possibly relevant: a85a6c86c25b ("driver core: platform: Clarify that
IRQ 0 is invalid")

> +		pci_err(pdev,
> +			"DOE [%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",

Wouldn't make a big difference, but could consider something like this
for enforced consistency:

  #define dev_fmt(fmt) "DOE: " fmt

> +	case DOE_WAIT_ABORT:
> +	case DOE_WAIT_ABORT_ON_ERR:
> +		prev_state = doe_mb->state;
> +
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> +			doe_mb->state = DOE_IDLE;
> +			/* Back to normal state - carry on */
> +			retire_cur_task(doe_mb);
> +		} else if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> +			/* Task has timed out and is dead - abort */
> +			pci_err(pdev, "DOE [%x] ABORT timed out\n",
> +				doe_mb->cap_offset);
> +			set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +			retire_cur_task(doe_mb);
> +		}
> +
> +		/*
> +		 * For deliberately triggered abort, someone is
> +		 * waiting.
> +		 */
> +		if (prev_state == DOE_WAIT_ABORT) {
> +			if (task)
> +				signal_task_complete(task, -EFAULT);
> +			complete(&doe_mb->abort_c);
> +		}
> +
> +		return;
> +	}

The "return" in each case is perfectly correct, but it feels a little
more conventional to make them "break" and return once here after the
switch to make it clear that the only way to get to the labels is via
an error path "goto".

> +err_abort:
> +	doe_mb->state = DOE_WAIT_ABORT_ON_ERR;
> +	pci_doe_abort_start(doe_mb);
> +err_busy:
> +	signal_task_complete(task, rc);
> +	if (doe_mb->state == DOE_IDLE)
> +		retire_cur_task(doe_mb);
> +}

> +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call

s/MSIx/MSI-X/ (typical spelling in spec)

> +	 * this multiple times and thus is called here to ensure that mastering
> +	 * is enabled even if the driver has done so.
> +	 */
> +	pci_set_master(pdev);
> +	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
> +			     "DOE[%d:%s]", irq, pci_name(pdev));

I assume the "DOE[%d:%s]" part appears in /proc/interrupts?  Is it
redundant to include "irq", since /proc/interrupts already prints it,
or is there somewhere else where "irq" is useful?

How does the user associate this IRQ in /proc/interrupts with a
specific DOE capability?  Should we include the cap_offset along with
the pci_name()?

> + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> + *
> + * @pdev: The PCI device
> + * @offset: Offset of the DOE mailbox
> + *
> + * Returns: irq number on success
> + *	    -errno if irqs are not supported on this mailbox

I normally capitalize IRQ/IRQs in comments.  There are probably others
throughout the file.  I notice some are already capitalized but not all.

> + */
> +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> +{
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> +		return -EOPNOTSUPP;
> +
> +	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);

Confusing function name (and comment) since PCI_DOE_CAP_IRQ is an
Interrupt Message Number that has nothing to do with Linux IRQ
numbers.

I see we already have PCI_EXP_FLAGS_IRQ, PCI_ERR_ROOT_AER_IRQ,
PCI_EXP_DPC_IRQ, so I guess you're in good company.

At least maybe update the comment to say "Interrupt Message Number"
instead of "irq".

> + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> + *			     protocol
> + * @doe_mb: DOE mailbox capability to query
> + * @vid: Protocol Vendor ID
> + * @type: Protocol type
> + *
> + * RETURNS: True if the DOE mailbox supports the protocol specified

Is the typical use that the caller has a few specific protocols it
cares about?  There's no case where a caller might want to enumerate
them all?  I guess they're all in prots[], but that's supposed to be
opaque to users.

> + */
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> +{
> +	int i;
> +
> +	/* The discovery protocol must always be supported */
> +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> +		return true;
> +
> +	for (i = 0; i < doe_mb->num_prots; i++)
> +		if ((doe_mb->prots[i].vid == vid) &&
> +		    (doe_mb->prots[i].type == type))
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);

> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload

Size is in dwords, not bytes, I guess?

> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload
> + * @rv: Return value.  Length of received response or error
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +};
