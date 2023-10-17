Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227F87CBD0A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjJQIE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQIEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 04:04:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A4AB
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:04:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso4833584a12.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697529891; x=1698134691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPJyoJIwpE+82CHC/pcghGRE1m5gWRE3gtJYmta+U40=;
        b=shfqLy4vyT/qV+TnHg6rYvooIEDRSkRpHhn0rxr/D6YQ3iDPAXW703UGxDA/CjMarE
         vdZS2mq+QGodz2eMMcup+alUPeRPXc0qtIZ1Rh2wnYGEiIc37S7XoNR6pXLy4zG0TqoZ
         SLASsE7WAigBdJfSfeSLWdL/8fIgU2LhV9JSwH5eycZW9t0TtprClIuhCo0CSZ9BTywo
         UR3dHR6BOPB2Mv6DzIafcQ92ZecFSPEZFxZQ8oAnjr4O7W9wLQJdV8E0QLwGm5sgKjlT
         d3ojqNvhO6OYqYYriLBa5Z9smOOi8uzwCMQVPH7jpwrqUsQd9CXQYv5H+8eXo7r9U90/
         UE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529891; x=1698134691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPJyoJIwpE+82CHC/pcghGRE1m5gWRE3gtJYmta+U40=;
        b=irfP8xXKtQpsrTHZNrUKK/lVtEtSV+KV19zcCo/kEXccuDTjMWLPqg+2H/H2TBa74o
         aIG+RwVrnEHhzE0oQQqIneFlSDx/yAfDyoHciN5kYZululGv8cdwAqnd/dHHIW1ua79g
         00kuUpM9sVK67UsEFKZ80WKvHTtUFlrbdAwCJi92x3RJ5hiAF/STMyUGhkxOJtxrFDtg
         xSPOgxQB1lxRfTucXYtXviVsjnrKI2JJjbZWWvk+KyFx2kGI9lW1hTQrOQzjUrIl4oOI
         AeSi49b0ijetIde9/hGCyOFeuhSj/TKIbbr1eDxWjwS+1ikU3aQJSL8joFTpxlXcBJO/
         +Agw==
X-Gm-Message-State: AOJu0YykaBj33CMMDgSH3GCdhaSJIhre2c1vIGdWN1NFFpoC4PVb2SOf
        kSaIFHtvWJkxIYasSY2BPrZEPw==
X-Google-Smtp-Source: AGHT+IH8uXVPlRbctlNzEuAo93MBn/Rg20BKZZWNK28RCp9tVq9jqn+j050BW1N4iwtuIe8VS8IF7g==
X-Received: by 2002:a17:907:3da9:b0:9c4:d641:aff9 with SMTP id he41-20020a1709073da900b009c4d641aff9mr1179249ejc.67.1697529887914;
        Tue, 17 Oct 2023 01:04:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d1-20020a170906544100b009adc81bb544sm743302ejp.106.2023.10.17.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:04:47 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:04:46 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 03/12] devlink: Acquire device lock during
 reload
Message-ID: <ZS5AHnlJp6orqdLb@nanopsycho>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-4-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-4-idosch@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tue, Oct 17, 2023 at 09:42:48AM CEST, idosch@nvidia.com wrote:
>Device drivers register with devlink from their probe routines (under
>the device lock) by acquiring the devlink instance lock and calling
>devl_register().
>
>Drivers that support a devlink reload usually implement the
>reload_{down, up}() operations in a similar fashion to their remove and
>probe routines, respectively.
>
>However, while the remove and probe routines are invoked with the device
>lock held, the reload operations are only invoked with the devlink
>instance lock held. It is therefore impossible for drivers to acquire
>the device lock from their reload operations, as this would result in
>lock inversion.
>
>The motivating use case for invoking the reload operations with the
>device lock held is in mlxsw which needs to trigger a PCI reset as part
>of the reload. The driver cannot call pci_reset_function() as this
>function acquires the device lock. Instead, it needs to call
>__pci_reset_function_locked which expects the device lock to be held.
>
>To that end, adjust devlink to always acquire the device lock before the
>devlink instance lock when performing a reload. Do that both when reload
>is triggered explicitly by user space and when it is triggered as part
>of netns dismantle.
>
>Tested the following flows with netdevsim and mlxsw while lockdep is
>enabled:
>
>netdevsim:
>
> # echo "10 1" > /sys/bus/netdevsim/new_device
> # devlink dev reload netdevsim/netdevsim10
> # ip netns add bla
> # devlink dev reload netdevsim/netdevsim10 netns bla
> # ip netns del bla
> # echo 10 > /sys/bus/netdevsim/del_device
>
>mlxsw:
>
> # devlink dev reload pci/0000:01:00.0
> # ip netns add bla
> # devlink dev reload pci/0000:01:00.0 netns bla
> # ip netns del bla
> # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
> # echo 1 > /sys/bus/pci/rescan
>
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>---
> net/devlink/core.c          |  4 ++--
> net/devlink/dev.c           |  8 ++++++++
> net/devlink/devl_internal.h | 19 ++++++++++++++++++-
> net/devlink/health.c        |  3 ++-
> net/devlink/netlink.c       | 21 ++++++++++++++-------
> net/devlink/region.c        |  3 ++-
> 6 files changed, 46 insertions(+), 12 deletions(-)
>
>diff --git a/net/devlink/core.c b/net/devlink/core.c
>index 5b8b692b8c76..0f866f2cbaf6 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -502,14 +502,14 @@ static void __net_exit devlink_pernet_pre_exit(struct net *net)
> 	 * all devlink instances from this namespace into init_net.
> 	 */
> 	devlinks_xa_for_each_registered_get(net, index, devlink) {
>-		devl_lock(devlink);
>+		devl_dev_lock(devlink, true);
> 		err = 0;
> 		if (devl_is_registered(devlink))
> 			err = devlink_reload(devlink, &init_net,
> 					     DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
> 					     DEVLINK_RELOAD_LIMIT_UNSPEC,
> 					     &actions_performed, NULL);
>-		devl_unlock(devlink);
>+		devl_dev_unlock(devlink, true);
> 		devlink_put(devlink);
> 		if (err && err != -EOPNOTSUPP)
> 			pr_warn("Failed to reload devlink instance into init_net\n");
>diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>index dc8039ca2b38..70cebe716187 100644
>--- a/net/devlink/dev.c
>+++ b/net/devlink/dev.c
>@@ -4,6 +4,7 @@
>  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
>  */
> 
>+#include <linux/device.h>
> #include <net/genetlink.h>
> #include <net/sock.h>
> #include "devl_internal.h"
>@@ -433,6 +434,13 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
> 	struct net *curr_net;
> 	int err;
> 
>+	/* Make sure the reload operations are invoked with the device lock
>+	 * held to allow drivers to trigger functionality that expects it
>+	 * (e.g., PCI reset) and to close possible races between these
>+	 * operations and probe/remove.
>+	 */
>+	device_lock_assert(devlink->dev);
>+
> 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
> 	       sizeof(remote_reload_stats));
> 
>diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>index 741d1bf1bec8..a9c5e52c40a7 100644
>--- a/net/devlink/devl_internal.h
>+++ b/net/devlink/devl_internal.h
>@@ -3,6 +3,7 @@
>  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
>  */
> 
>+#include <linux/device.h>
> #include <linux/etherdevice.h>
> #include <linux/mutex.h>
> #include <linux/netdevice.h>
>@@ -96,6 +97,20 @@ static inline bool devl_is_registered(struct devlink *devlink)
> 	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
> }
> 
>+static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
>+{
>+	if (dev_lock)
>+		device_lock(devlink->dev);
>+	devl_lock(devlink);
>+}
>+
>+static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
>+{
>+	devl_unlock(devlink);
>+	if (dev_lock)
>+		device_unlock(devlink->dev);
>+}
>+
> typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
> typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
> 				      u32 rel_index);
>@@ -113,6 +128,7 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
> /* Netlink */
> #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
> #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
>+#define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
> 
> enum devlink_multicast_groups {
> 	DEVLINK_MCGRP_CONFIG,
>@@ -140,7 +156,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
> 				       int flags);
> 
> struct devlink *
>-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
>+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
>+			    bool dev_lock);
> 
> int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
> 		      devlink_nl_dump_one_func_t *dump_one);
>diff --git a/net/devlink/health.c b/net/devlink/health.c
>index 51e6e81e31bb..3c4c049c3636 100644
>--- a/net/devlink/health.c
>+++ b/net/devlink/health.c
>@@ -1266,7 +1266,8 @@ devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
> 	struct nlattr **attrs = info->attrs;
> 	struct devlink *devlink;
> 
>-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
>+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
>+					      false);
> 	if (IS_ERR(devlink))
> 		return NULL;
> 
>diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
>index 499304d9de49..14d598000d72 100644
>--- a/net/devlink/netlink.c
>+++ b/net/devlink/netlink.c
>@@ -124,7 +124,8 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
> }
> 
> struct devlink *
>-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
>+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
>+			    bool dev_lock)
> {
> 	struct devlink *devlink;
> 	unsigned long index;
>@@ -138,12 +139,12 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
> 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
> 
> 	devlinks_xa_for_each_registered_get(net, index, devlink) {
>-		devl_lock(devlink);
>+		devl_dev_lock(devlink, dev_lock);
> 		if (devl_is_registered(devlink) &&
> 		    strcmp(devlink->dev->bus->name, busname) == 0 &&
> 		    strcmp(dev_name(devlink->dev), devname) == 0)
> 			return devlink;
>-		devl_unlock(devlink);
>+		devl_dev_unlock(devlink, dev_lock);
> 		devlink_put(devlink);
> 	}
> 
>@@ -155,9 +156,12 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
> {
> 	struct devlink_port *devlink_port;
> 	struct devlink *devlink;
>+	bool dev_lock;
> 	int err;
> 
>-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs);
>+	dev_lock = !!(flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK);

I know you are aware, but just for the record: This conflicts
with my patchset "devlink: finish conversion to generated split_ops"
where I'm removing use of internal_flags. Ops that need this (should
be only reload) would need separate devlink_nl_pre/post_doit() helpers.

Otherwise the patch looks fine to me.


>+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
>+					      dev_lock);
> 	if (IS_ERR(devlink))
> 		return PTR_ERR(devlink);
> 
>@@ -177,7 +181,7 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
> 	return 0;
> 
> unlock:
>-	devl_unlock(devlink);
>+	devl_dev_unlock(devlink, dev_lock);
> 	devlink_put(devlink);
> 	return err;
> }
>@@ -205,9 +209,11 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
> 			  struct sk_buff *skb, struct genl_info *info)
> {
> 	struct devlink *devlink;
>+	bool dev_lock;
> 
>+	dev_lock = !!(ops->internal_flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK);
> 	devlink = info->user_ptr[0];
>-	devl_unlock(devlink);
>+	devl_dev_unlock(devlink, dev_lock);
> 	devlink_put(devlink);
> }
> 
>@@ -219,7 +225,7 @@ static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
> 	struct devlink *devlink;
> 	int err;
> 
>-	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs);
>+	devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), attrs, false);
> 	if (IS_ERR(devlink))
> 		return PTR_ERR(devlink);
> 	err = dump_one(msg, devlink, cb, flags | NLM_F_DUMP_FILTERED);
>@@ -420,6 +426,7 @@ static const struct genl_small_ops devlink_nl_small_ops[40] = {
> 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> 		.doit = devlink_nl_cmd_reload,
> 		.flags = GENL_ADMIN_PERM,
>+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEV_LOCK,
> 	},
> 	{
> 		.cmd = DEVLINK_CMD_PARAM_SET,
>diff --git a/net/devlink/region.c b/net/devlink/region.c
>index d197cdb662db..30c6c49ec10b 100644
>--- a/net/devlink/region.c
>+++ b/net/devlink/region.c
>@@ -883,7 +883,8 @@ int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
> 
> 	start_offset = state->start_offset;
> 
>-	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
>+	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs,
>+					      false);
> 	if (IS_ERR(devlink))
> 		return PTR_ERR(devlink);
> 
>-- 
>2.40.1
>
>
