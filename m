Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA1513CD3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbiD1UvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1UvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 16:51:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A128878E;
        Thu, 28 Apr 2022 13:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06829B83036;
        Thu, 28 Apr 2022 20:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19354C385AD;
        Thu, 28 Apr 2022 20:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651178863;
        bh=+vVNZguiz+/eS3ts46NEzw5RtmbAO/pDo7nfGJJkOec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k+8fD4QNWRemaZyEweZK+x5TjcPSzL3PrtoevcFE1SspwLWBAoZWBfWlVYFZX+8Et
         0J3YXEa8vvC7ZDv04idXUYd2Wh8Nt5Mh9u8bUr3vkC9WqSrnj7V4ySs7icj+zD2SKT
         3fTf7PpszJO+MaHORvKi9TlD7EM1jJs2oxKUnzXW2Bv3OrSRHeoNUTW97CssZUW9NW
         eh+LOVw1K94rpNllXyQZmSdnw6K5TRSjqeH8ZRa36HdeI3yYo5UcTZQCgTVin2n8KH
         q2jkpsCnx/cUYXvuug+L7MYYSvp86ip8+Km+6Q8vJzCfqIRWAliF3NivB6tO54o4V1
         IR3d9hcTPB4sw==
Date:   Thu, 28 Apr 2022 15:47:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6] PCI hotplug: rpaphp: Error out on busy status from
 get-sensor-state
Message-ID: <20220428204740.GA42242@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165099464934.1658371.1526973220374528897.stgit@jupiter>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 26, 2022 at 11:07:39PM +0530, Mahesh Salgaonkar wrote:
> When certain PHB HW failure causes phyp to recover PHB, it marks the PE
> state as temporarily unavailable until recovery is complete. This also
> triggers an EEH handler in Linux which needs to notify drivers, and perform
> recovery. But before notifying the driver about the PCI error it uses
> get_adapter_state()->get-sensor-state() operation of the hotplug_slot to
> determine if the slot contains a device or not. if the slot is empty, the
                                                  If
> recovery is skipped entirely.
> 
> However on certain PHB failures, the rtas call get-sensor-state() returns
> extended busy error (9902) until PHB is recovered by phyp. Once PHB is
> recovered, the get-sensor-state() returns success with correct presence
> status. The RTAS call interface rtas_get_sensor() loops over the rtas call
> on extended delay return code (9902) until the return value is either
> success (0) or error (-1). This causes the EEH handler to get stuck for ~6
> seconds before it could notify that the pci error has been detected and
> stop any active operations. Hence with running I/O traffic, during this 6
> seconds, the network driver continues its operation and hits a timeout
> (netdev watchdog). On timeouts, network driver go into ffdc capture mode

I assume ffdc == First Failure Data Capture (please expand and remove
the redundant "capture")  Is this a powerpc thing?  "ffdc" doesn't
occur in drivers/net, so I don't know what network driver this refers
to.

> and reset path assuming the PCI device is in fatal condition. This
> sometimes causes EEH recovery to fail. This impacts the ssh connection and
> leads to the system being inaccessible.
> 
> ------------
> [52732.244731] DEBUG: ibm_read_slot_reset_state2()
> [52732.244762] DEBUG: ret = 0, rets[0]=5, rets[1]=1, rets[2]=4000, rets[3]=>
> [52732.244798] DEBUG: in eeh_slot_presence_check
> [52732.244804] DEBUG: error state check
> [52732.244807] DEBUG: Is slot hotpluggable
> [52732.244810] DEBUG: hotpluggable ops ?
> [52732.244953] DEBUG: Calling ops->get_adapter_status
> [52732.244958] DEBUG: calling rpaphp_get_sensor_state
> [52736.564262] ------------[ cut here ]------------
> [52736.564299] NETDEV WATCHDOG: enP64p1s0f3 (tg3): transmit queue 0 timed o>
> [52736.564324] WARNING: CPU: 1442 PID: 0 at net/sched/sch_generic.c:478 dev>
> [...]
> [52736.564505] NIP [c000000000c32368] dev_watchdog+0x438/0x440
> [52736.564513] LR [c000000000c32364] dev_watchdog+0x434/0x440
> ------------
> 
> To avoid this issue, fix the pci hotplug driver (rpaphp) to return an error
> if the slot presence state can not be detected immediately while PE is in
> EEH recovery state. Current implementation uses rtas_get_sensor() API which
> blocks the slot check state until rtas call returns success. Change
> rpaphp_get_sensor_state() to invoke rtas_call(get-sensor-state) directly
> only if the respective pe is in EEH recovery state, and take actions based
> on rtas return status.

I'm not too clear on what the problem is.  I guess you don't want the
netdev watchdog timeout.  Is the NIC still operating?  It's just the
PHB leading to the NIC that has an issue?

Apparently the remedy is to return -ENODEV (from SLOT_NOT_USABLE ==
-9002) from rpaphp_get_sensor_state() instead of doing the retries.
It would be good to explain why *that* is safe.

> In normal cases (non-EEH case) rpaphp_get_sensor_state() will continue to
> invoke rtas_get_sensor() as it was earlier with no change in existing
> behavior.

Nits:
Follow historical convention in subject line.
s/phyp/pHyp/   (or whatever the normal styling is)
s/pe/PE/       (used inconsistently above and in comment)
s/rtas/RTAS/   (Michael mentioned this already, but I guess you missed some)
s/pci/PCI/
s/ffdc/First Failure Data Capture/   (or the correct expansion)
Make similar changes in the comment below.

> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
> Change in v6:
> - Fixed typo's in the patch description as per review comments.
> 
> Change in v5:
> - Fixup #define macros with parentheses around the values.
> 
> Change in V4:
> - Error out on sensor busy only if pe is going through EEH recovery instead
>   of always error out.
> 
> Change in V3:
> - Invoke rtas_call(get-sensor-state) directly from
>   rpaphp_get_sensor_state() directly and do special handling.
> - See v2 at
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-November/237336.html
> 
> Change in V2:
> - Alternate approach to fix the EEH issue instead of delaying slot presence
>   check proposed at
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-November/236956.html
> 
> Also refer:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-November/237027.html
> ---
>  drivers/pci/hotplug/rpaphp_pci.c |  100 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
> index c380bdacd1466..e463e915a052a 100644
> --- a/drivers/pci/hotplug/rpaphp_pci.c
> +++ b/drivers/pci/hotplug/rpaphp_pci.c
> @@ -18,12 +18,107 @@
>  #include "../pci.h"		/* for pci_add_new_bus */
>  #include "rpaphp.h"
>  
> +/*
> + * RTAS call get-sensor-state(DR_ENTITY_SENSE) return values as per PAPR:
> + *    -1: Hardware Error
> + *    -2: RTAS_BUSY
> + *    -3: Invalid sensor. RTAS Parameter Error.
> + * -9000: Need DR entity to be powered up and unisolated before RTAS call
> + * -9001: Need DR entity to be powered up, but not unisolated, before RTAS call
> + * -9002: DR entity unusable
> + *  990x: Extended delay - where x is a number in the range of 0-5
> + */
> +#define RTAS_HARDWARE_ERROR	(-1)
> +#define RTAS_INVALID_SENSOR	(-3)
> +#define SLOT_UNISOLATED		(-9000)
> +#define SLOT_NOT_UNISOLATED	(-9001)

I would say "isolated" instead of "not unisolated", but I suppose this
follows language in the spec.  If so, you should follow the spec.

> +#define SLOT_NOT_USABLE		(-9002)
> +
> +static int rtas_to_errno(int rtas_rc)
> +{
> +	int rc;
> +
> +	switch (rtas_rc) {
> +	case RTAS_HARDWARE_ERROR:
> +		rc = -EIO;
> +		break;
> +	case RTAS_INVALID_SENSOR:
> +		rc = -EINVAL;
> +		break;
> +	case SLOT_UNISOLATED:
> +	case SLOT_NOT_UNISOLATED:
> +		rc = -EFAULT;
> +		break;
> +	case SLOT_NOT_USABLE:
> +		rc = -ENODEV;
> +		break;
> +	case RTAS_BUSY:
> +	case RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX:
> +		rc = -EBUSY;
> +		break;
> +	default:
> +		err("%s: unexpected RTAS error %d\n", __func__, rtas_rc);
> +		rc = -ERANGE;
> +		break;
> +	}
> +	return rc;

This basically duplicates rtas_error_rc().  Why do we need two copies?

> +}
> +
> +/*
> + * get_adapter_status() can be called by the EEH handler during EEH recovery.
> + * On certain PHB failures, the rtas call get-sensor-state() returns extended
> + * busy error (9902) until PHB is recovered by phyp. The rtas call interface
> + * rtas_get_sensor() loops over the rtas call on extended delay return code
> + * (9902) until the return value is either success (0) or error (-1). This
> + * causes the EEH handler to get stuck for ~6 seconds before it could notify
> + * that the pci error has been detected and stop any active operations. This
> + * sometimes causes EEH recovery to fail. To avoid this issue, invoke
> + * rtas_call(get-sensor-state) directly if the respective pe is in EEH recovery
> + * state and return -EBUSY error based on rtas return status. This will help
> + * the EEH handler to notify the driver about the pci error immediately and
> + * successfully proceed with EEH recovery steps.
> + */
> +static int __rpaphp_get_sensor_state(struct slot *slot, int *state)
> +{
> +	int rc;
> +#ifdef CONFIG_EEH
> +	int token = rtas_token("get-sensor-state");
> +	struct pci_dn *pdn;
> +	struct eeh_pe *pe;
> +	struct pci_controller *phb = PCI_DN(slot->dn)->phb;
> +
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return -ENOENT;
> +
> +	/*
> +	 * Fallback to existing method for empty slot or pe isn't in EEH
> +	 * recovery.
> +	 */
> +	if (list_empty(&PCI_DN(phb->dn)->child_list))
> +		goto fallback;
> +
> +	pdn = list_first_entry(&PCI_DN(phb->dn)->child_list,
> +			       struct pci_dn, list);

I guess you don't need locking to ensure that child_list doesn't
become empty between the list_empty() and the list_first_entry()?
I didn't see locking at other places that traverse it, but it's not
obvious to me what protects it.

> +	pe = eeh_dev_to_pe(pdn->edev);
> +	if (pe && (pe->state & EEH_PE_RECOVERING)) {
> +		rc = rtas_call(token, 2, 2, state, DR_ENTITY_SENSE,
> +			       slot->index);
> +		if (rc)
> +			rc = rtas_to_errno(rc);
> +		return rc;

I'd probably make rtas_to_errno(0) return 0, then do:

  return rtas_to_errno(rc);

> +	}
> +fallback:
> +#endif
> +	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
> +	return rc;

  return rtas_get_sensor(DR_ENTITY_SENSE, ...);

> +}
> +
>  int rpaphp_get_sensor_state(struct slot *slot, int *state)
>  {
>  	int rc;
>  	int setlevel;
>  
> -	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
> +	rc = __rpaphp_get_sensor_state(slot, state);
>  
>  	if (rc < 0) {
>  		if (rc == -EFAULT || rc == -EEXIST) {
> @@ -39,8 +134,7 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state)
>  				dbg("%s: power on slot[%s] failed rc=%d.\n",
>  				    __func__, slot->name, rc);
>  			} else {
> -				rc = rtas_get_sensor(DR_ENTITY_SENSE,
> -						     slot->index, state);
> +				rc = __rpaphp_get_sensor_state(slot, state);
>  			}
>  		} else if (rc == -ENODEV)
>  			info("%s: slot is unusable\n", __func__);
> 
> 
