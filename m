Return-Path: <linux-pci+bounces-11007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D0940C62
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5031D282E28
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84241922C1;
	Tue, 30 Jul 2024 08:54:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA343152;
	Tue, 30 Jul 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329698; cv=none; b=Ag9ekxlKp8FTKNUNHnVWh9OeaFKp3XzDlPprmDqcUClH/kgs2iLbbWXHGXrskMRGIDyHpPols5q8mur4Bfyw9wJaW9KrNSPmMpUzxK+36zPhhh4PATsH9FzxbfyWYx5K+yB7UDmjbhCpS79GyOK6UYA/C4wThQn+KkvMMxPuFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329698; c=relaxed/simple;
	bh=evmp6JIC0/O0Np7RtQdWKUhbbxAoESChjbkK9myxIVk=;
	h=Message-ID:From:Date:Subject:To:Cc; b=lMbPSuMOKLzJJ8yRONeZFhpsZJdEcUdpvP0R3JNDj6I/TL6akDXxPTFonY7LGPe5XQkOuwuFHeKQ5TV+8Z2Ilz4okIrPm0V4btrZjEHl0SXAOmEos4EC//08gr4ecmomJB6kUcAdiPMq/0w9sZe4I62OCbK07PZ5+oXt6PBQyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id E39131019178E;
	Tue, 30 Jul 2024 10:54:51 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id B46C7603B5E6;
	Tue, 30 Jul 2024 10:54:51 +0200 (CEST)
X-Mailbox-Line: From dd76a3196d5295fa7575bf149d890e647fbe0fd6 Mon Sep 17 00:00:00 2001
Message-ID: <dd76a3196d5295fa7575bf149d890e647fbe0fd6.1722329230.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 10:54:51 +0200
Subject: [PATCH 5.15-stable 1/3] locking: Introduce __cleanup() based
 infrastructure
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

commit 54da6a0924311c7cf5015533991e44fb8eb12773 upstream.

Use __attribute__((__cleanup__(func))) to build:

 - simple auto-release pointers using __free()

 - 'classes' with constructor and destructor semantics for
   scope-based resource management.

 - lock guards based on the above classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org
---
 include/linux/cleanup.h             | 171 ++++++++++++++++++++++++++++
 include/linux/compiler-clang.h      |   9 ++
 include/linux/compiler_attributes.h |   6 +
 include/linux/device.h              |   7 ++
 include/linux/file.h                |   6 +
 include/linux/irqflags.h            |   7 ++
 include/linux/mutex.h               |   4 +
 include/linux/percpu.h              |   4 +
 include/linux/preempt.h             |   5 +
 include/linux/rcupdate.h            |   3 +
 include/linux/rwsem.h               |   8 ++
 include/linux/sched/task.h          |   2 +
 include/linux/slab.h                |   4 +
 include/linux/spinlock.h            |  31 +++++
 include/linux/srcu.h                |   5 +
 scripts/checkpatch.pl               |   2 +-
 16 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/cleanup.h

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
new file mode 100644
index 000000000000..53f1a7a932b0
--- /dev/null
+++ b/include/linux/cleanup.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GUARDS_H
+#define __LINUX_GUARDS_H
+
+#include <linux/compiler.h>
+
+/*
+ * DEFINE_FREE(name, type, free):
+ *	simple helper macro that defines the required wrapper for a __free()
+ *	based cleanup function. @free is an expression using '_T' to access
+ *	the variable.
+ *
+ * __free(name):
+ *	variable attribute to add a scoped based cleanup to the variable.
+ *
+ * no_free_ptr(var):
+ *	like a non-atomic xchg(var, NULL), such that the cleanup function will
+ *	be inhibited -- provided it sanely deals with a NULL value.
+ *
+ * return_ptr(p):
+ *	returns p while inhibiting the __free().
+ *
+ * Ex.
+ *
+ * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+ *
+ *	struct obj *p __free(kfree) = kmalloc(...);
+ *	if (!p)
+ *		return NULL;
+ *
+ *	if (!init_obj(p))
+ *		return NULL;
+ *
+ *	return_ptr(p);
+ */
+
+#define DEFINE_FREE(_name, _type, _free) \
+	static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
+
+#define __free(_name)	__cleanup(__free_##_name)
+
+#define no_free_ptr(p) \
+	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+
+#define return_ptr(p)	return no_free_ptr(p)
+
+
+/*
+ * DEFINE_CLASS(name, type, exit, init, init_args...):
+ *	helper to define the destructor and constructor for a type.
+ *	@exit is an expression using '_T' -- similar to FREE above.
+ *	@init is an expression in @init_args resulting in @type
+ *
+ * EXTEND_CLASS(name, ext, init, init_args...):
+ *	extends class @name to @name@ext with the new constructor
+ *
+ * CLASS(name, var)(args...):
+ *	declare the variable @var as an instance of the named class
+ *
+ * Ex.
+ *
+ * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
+ *
+ *	CLASS(fdget, f)(fd);
+ *	if (!f.file)
+ *		return -EBADF;
+ *
+ *	// use 'f' without concern
+ */
+
+#define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
+typedef _type class_##_name##_t;					\
+static inline void class_##_name##_destructor(_type *p)			\
+{ _type _T = *p; _exit; }						\
+static inline _type class_##_name##_constructor(_init_args)		\
+{ _type t = _init; return t; }
+
+#define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+typedef class_##_name##_t class_##_name##ext##_t;			\
+static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
+{ class_##_name##_destructor(p); }					\
+static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+{ class_##_name##_t t = _init; return t; }
+
+#define CLASS(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
+
+
+/*
+ * DEFINE_GUARD(name, type, lock, unlock):
+ *	trivial wrapper around DEFINE_CLASS() above specifically
+ *	for locks.
+ *
+ * guard(name):
+ *	an anonymous instance of the (guard) class
+ *
+ * scoped_guard (name, args...) { }:
+ *	similar to CLASS(name, scope)(args), except the variable (with the
+ *	explicit name 'scope') is declard in a for-loop such that its scope is
+ *	bound to the next (compound) statement.
+ *
+ */
+
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
+
+#define guard(_name) \
+	CLASS(_name, __UNIQUE_ID(guard))
+
+#define scoped_guard(_name, args...)					\
+	for (CLASS(_name, scope)(args),					\
+	     *done = NULL; !done; done = (void *)1)
+
+/*
+ * Additional helper macros for generating lock guards with types, either for
+ * locks that don't have a native type (eg. RCU, preempt) or those that need a
+ * 'fat' pointer (eg. spin_lock_irqsave).
+ *
+ * DEFINE_LOCK_GUARD_0(name, lock, unlock, ...)
+ * DEFINE_LOCK_GUARD_1(name, type, lock, unlock, ...)
+ *
+ * will result in the following type:
+ *
+ *   typedef struct {
+ *	type *lock;		// 'type := void' for the _0 variant
+ *	__VA_ARGS__;
+ *   } class_##name##_t;
+ *
+ * As above, both _lock and _unlock are statements, except this time '_T' will
+ * be a pointer to the above struct.
+ */
+
+#define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef struct {							\
+	_type *lock;							\
+	__VA_ARGS__;							\
+} class_##_name##_t;							\
+									\
+static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+{									\
+	if (_T->lock) { _unlock; }					\
+}
+
+
+#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+{									\
+	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
+	_lock;								\
+	return _t;							\
+}
+
+#define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
+static inline class_##_name##_t class_##_name##_constructor(void)	\
+{									\
+	class_##_name##_t _t = { .lock = (void*)1 },			\
+			 *_T __maybe_unused = &_t;			\
+	_lock;								\
+	return _t;							\
+}
+
+#define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_1(_name, _type, _lock)
+
+#define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_0(_name, _lock)
+
+#endif /* __LINUX_GUARDS_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3c4de9b6c6e3..e75768ca8c18 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,6 +5,15 @@
 
 /* Compiler specific definitions for Clang compiler */
 
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://reviews.llvm.org/D152180
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
 /* same as gcc, this was present in clang-2.6 so we can assume it works
  * with any version that can compile the kernel
  */
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 932b8fd6f36f..5ee9e2aeab63 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -80,6 +80,12 @@
  */
 #define __cold                          __attribute__((__cold__))
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
+ */
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
 /*
  * Note the long name.
  *
diff --git a/include/linux/device.h b/include/linux/device.h
index 3e04bd84f126..3826d3a0c625 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,6 +30,7 @@
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
+#include <linux/cleanup.h>
 #include <asm/device.h>
 
 struct device;
@@ -822,6 +823,9 @@ void device_unregister(struct device *dev);
 void device_initialize(struct device *dev);
 int __must_check device_add(struct device *dev);
 void device_del(struct device *dev);
+
+DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
+
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
@@ -950,6 +954,9 @@ extern int (*platform_notify_remove)(struct device *dev);
  */
 struct device *get_device(struct device *dev);
 void put_device(struct device *dev);
+
+DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
+
 bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
diff --git a/include/linux/file.h b/include/linux/file.h
index 51e830b4fe3a..6726240b9279 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/posix_types.h>
 #include <linux/errno.h>
+#include <linux/cleanup.h>
 
 struct file;
 
@@ -82,6 +83,8 @@ static inline void fdput_pos(struct fd f)
 	fdput(f);
 }
 
+DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
@@ -90,6 +93,9 @@ extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 
+DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
+	     get_unused_fd_flags(flags), unsigned flags)
+
 extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 37738ec87de3..c4288c7ae613 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -260,4 +261,10 @@ extern void warn_bogus_irq_restore(void);
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DEFINE_LOCK_GUARD_0(irqsave,
+		    local_irq_save(_T->flags),
+		    local_irq_restore(_T->flags),
+		    unsigned long flags)
+
 #endif
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 9ef01b9d2456..5b5630e58407 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/cleanup.h>
 
 struct device;
 
@@ -246,4 +247,7 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af742c80..c9a84532bb79 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -9,6 +9,7 @@
 #include <linux/printk.h>
 #include <linux/pfn.h>
 #include <linux/init.h>
+#include <linux/cleanup.h>
 
 #include <asm/percpu.h>
 
@@ -134,6 +135,9 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp);
 extern void __percpu *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(void __percpu *__pdata);
+
+DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
+
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
 #define alloc_percpu_gfp(type, gfp)					\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9c4534a69a8f..36c4233742a1 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cleanup.h>
 #include <linux/list.h>
 
 /*
@@ -431,4 +432,8 @@ static inline void migrate_enable(void) { }
 
 #endif /* CONFIG_SMP */
 
+DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d908af591733..b45cf762ed1e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -27,6 +27,7 @@
 #include <linux/preempt.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
 
@@ -1057,4 +1058,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 352c6127cb90..458a0c92cc68 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+#include <linux/cleanup.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
@@ -202,6 +203,13 @@ extern void up_read(struct rw_semaphore *sem);
  */
 extern void up_write(struct rw_semaphore *sem);
 
+DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
+DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+
+DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
+DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
+
+
 /*
  * downgrade write lock to read lock
  */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0c2d00809915..fa9f79ac4bac 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -141,6 +141,8 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
+DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
+
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 083f3ce550bc..78a471aa8145 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/cleanup.h>
 
 
 /*
@@ -186,6 +187,9 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+
+DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+
 #ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 45310ea1b1d7..44ac0897c26c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -61,6 +61,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
@@ -506,4 +507,34 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
+		    spin_lock(_T->lock),
+		    spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
+		    spin_lock_irq(_T->lock),
+		    spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
+		    spin_lock_irqsave(_T->lock, _T->flags),
+		    spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af..e94687215fbe 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -211,4 +211,9 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
+		    _T->idx = srcu_read_lock(_T->lock),
+		    srcu_read_unlock(_T->lock, _T->idx),
+		    int idx)
+
 #endif
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc447..b4fe18228805 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4895,7 +4895,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped_guard)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open
-- 
2.43.0


